import Foundation

public enum ApiError: Error {
    case timeout
    case noCacheResult
    case noResult
    case connectionError
    case unknown(error: Error)
}
