import Foundation


class PressReleaseDetailViewModel: Loadable {
    @Published var loadingState: LoadingState = .initializing
    @Published var pressRelease: PressRelease?
    
    @MainActor
    func getPressReleaseById(_ objectId: String) async {
        await loadingStateScope {
            pressRelease = try await PressReleaseRepositoryImpl.getPressReleaseById(objectId)
        }
    }
}
