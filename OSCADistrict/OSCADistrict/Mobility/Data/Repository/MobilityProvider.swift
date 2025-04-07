import Foundation
import Papyrus
import Factory

extension Container {
    var mobilityProvider: Factory<Provider> {
        Factory(self) {
            Provider(baseURL: "http://192.168.178.183:8080/api/").intercept { req, next in
                let res = try await next(req)
                print("Got a \(String(describing: res.statusCode)) for \(req.method) \(String(describing: req.url))")
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

