import Foundation
import SwiftUI

public protocol Loadable: AnyObject, ObservableObject {
    var loadingState: LoadingState { set get }
}

extension Loadable {
    func loadingStateScope(_ block: () async throws -> Void, noResult: LocalizedStringKey = "no_result") async {
        await updateLoadingState(.initializing)
        do {
            try await block()
            await updateLoadingState(.loaded)
        } catch {
            switch error {
            case ApiError.connectionError:
                await updateLoadingState(.error(errorMessage: "connection_error"))
            case ApiError.noCacheResult, ApiError.noResult:
                await updateLoadingState(.loaded)
            case ApiError.timeout:
                await updateLoadingState(.error(errorMessage: "timeout"))
            default:
                await updateLoadingState(.error(errorMessage: "unknown"))
            }
        }
    }
    
    func updateLoadingState(_ loadingState: LoadingState) async {
        guard self.loadingState != loadingState else { return }

        await MainActor.run {
            self.loadingState = loadingState
        }
    }
}
