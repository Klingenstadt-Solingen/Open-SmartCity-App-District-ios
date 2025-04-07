import Foundation
import ParseCore
import OSLog


/**
 Catches errors while executing a async query
 */
func streamParse<T, O>(_ query: PFQuery<O>, objectId: String) -> AsyncThrowingStream<T, any Error> {
    return AsyncThrowingStream(bufferingPolicy: .bufferingNewest(1)) { continuation in
        var hasResult = false
        let hasCacheResult = query.hasCachedResult

        query.getObjectInBackground(withId: objectId) { result, error in
            if let result = result as? T {
                continuation.yield(result)
                if hasResult || !hasCacheResult {
                    continuation.finish()
                    return
                }
                hasResult = true
            } else if let error = error {
                guard !hasResult else {
                    continuation.finish()
                    return
                }
                let apiError = getError(error)

                if case .noCacheResult = apiError, case .cacheThenNetwork = query.cachePolicy {
                    return
                }
                continuation.finish(throwing: apiError)
            }
        }
        continuation.onTermination = { _ in
            query.cancel()
        }
    }
}

/**
 Catches errors while executing a async array query
 */
func streamParse<T, O>(_ query: PFQuery<O>) -> AsyncThrowingStream<[T], any Error> {
    var hasResult = false
    let hasCacheResult = query.hasCachedResult
    return AsyncThrowingStream(bufferingPolicy: .bufferingNewest(1)) { continuation in
        query.findObjectsInBackground { result, error in
            if let result = result as? [T] {
                continuation.yield(result)
                if hasResult || !hasCacheResult {
                    if(result.isEmpty) {
                        continuation.finish(throwing: ApiError.noResult)
                    } else {
                        continuation.finish()
                    }
                    return
                }
                hasResult = true
            } else if let error = error {
                guard !hasResult else {
                    continuation.finish()
                    return
                }
                let apiError = getError(error)

                if case .noCacheResult = apiError, case .cacheThenNetwork = query.cachePolicy {
                    return
                }
                continuation.finish(throwing: apiError)
            }
        }
        continuation.onTermination = { _ in
            query.cancel()
        }
    }
}


/**
 Catches errors while executing a async count  query
 */
func streamParseCount<T>(_ query: PFQuery<T>) -> AsyncStream<Int> {
    return AsyncStream { continuation in
        query.countObjectsInBackground { result, error in
            continuation.yield(Int(result))
        }
    }
}

/**
 Catches errors while executing aquery
 */
func catchParse<T, O>(_ block: () async throws -> O) async throws -> T {
    do {
        let result = try await block()
        return result as! T
    } catch {
        throw getError(error)
    }
}


/**
 Catches errors while executing array query
 */
func catchParse<T, O>(_ block: () async throws  -> [O]) async throws -> [T] {
    do {
        let result = try await block()
        return result as! [T]
    } catch {
        throw getError(error)
    }
}


/**
 Proccesses Error into an Error Key
 */
func getError(_ error: Error) -> ApiError {
    if let nsError: NSError = error as NSError? {
        logError(nsError)

        if nsError.domain == PFParseErrorDomain {
            switch PFErrorCode(rawValue: nsError.code) {
            case .errorConnectionFailed:
                return .connectionError
            case .errorCacheMiss:
                return .noCacheResult
            case .errorObjectNotFound, .scriptError:
                return .noResult
            case .errorTimeout:
                return .timeout
            default:
                break
            }
        }
    }
    return .unknown(error: error)
}

/**
 Logs an Error
 */
func logError(_ nsError: NSError) {
    Logger().debug("\(nsError.domain) \(nsError.code): \(nsError.localizedDescription)")
}
