import Foundation
import Papyrus
import Factory


extension Container {
    var politicProvider: Factory<Provider> {
        Factory(self) {
            Provider(baseURL: "\(OSCADistrictSettings.shared.politicsURL ?? "")/api/").intercept { req, next in
                let start = Date()
                
                let res = try await next(req)
                let elapsedTime = String(format: "%.2fs", Date().timeIntervalSince(start))
#if DEBUG
                print("Got a \(String(describing: res.statusCode)) for \(req.method) \(String(describing: req.url))")
#endif
                if let error = res.error {
#if DEBUG
                    print(error)
#endif
                    switch (error as NSError).code {
                    case NSURLErrorCannotConnectToHost:
                        throw ApiError.timeout
                    case NSURLErrorNetworkConnectionLost:
                        throw ApiError.connectionError
                    case NSURLErrorTimedOut:
                        throw ApiError.timeout
                    default:
                        throw ApiError.unknown(error: error)
                    }
                } else if res.statusCode == 404 {
                    throw ApiError.noResult
                }
                return res
           
            }.modifyRequests { requestBuilder in
                requestBuilder.responseDecoder = JSONDecoder.iso8601
                requestBuilder.requestEncoder = JSONEncoder.iso8601
            }
        }.singleton
    }
}

extension JSONEncoder {
    static var custom: JSONEncoder {
        let encoder = JSONEncoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        encoder.dateEncodingStrategy = .formatted(formatter)
        return encoder
    }
    
    static var iso8601: JSONEncoder {
        let encoder = JSONEncoder()
        
        let iso8601Formatter = ISO8601DateFormatter()
        iso8601Formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        encoder.dateEncodingStrategy = .custom { (date, encoder) in
            let dateString = iso8601Formatter.string(from: date)
            var container = encoder.singleValueContainer()
            try container.encode(dateString)
        }
        return encoder
    }
}


extension JSONDecoder {
    static var custom: JSONDecoder {
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        decoder.dateDecodingStrategy = .formatted(formatter)
        return decoder
    }
    
    static var iso8601: JSONDecoder {
        let decoder = JSONDecoder()
        
        let iso8601Formatter = ISO8601DateFormatter()
        iso8601Formatter.formatOptions = .withFractionalSeconds
        
        let secondlessFormatter = DateFormatter()
        secondlessFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        
        decoder.dateDecodingStrategy = .custom { decoder -> Date in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            do {
                if let date = secondlessFormatter.date(from: dateString) {
                    return date
                } else {
                    throw DecodingError.dataCorruptedError(
                        in: container,
                        debugDescription: "Expected date (\(dateString)) string to be ISO8601-formatted."
                    )
                }
            } catch {
                if let date = iso8601Formatter.date(from: dateString) {
                    return date
                } else {
                    throw DecodingError.dataCorruptedError(
                        in: container,
                        debugDescription: "Expected date (\(dateString)) string to be ISO8601-formatted."
                    )
                }
            }
        }
        return decoder
    }
}

