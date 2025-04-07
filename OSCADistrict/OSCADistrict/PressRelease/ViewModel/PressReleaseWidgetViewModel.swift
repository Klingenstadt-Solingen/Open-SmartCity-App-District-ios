import Foundation


class PressReleaseWidgetViewModel: Loadable {
    @Published var loadingState: LoadingState = .initializing
    var newestPressReleases: [PressRelease] = []
    
    func getPressReleases(limit: Int = 5, districtState: DistrictState = .all) async {
        await loadingStateScope {
            let pressReleases = try await PressReleaseRepositoryImpl.getPressReleases(districtState: districtState, limit: limit)
            await MainActor.run {
                self.newestPressReleases = pressReleases
                loadingState = .loaded
            }
                
        }
    }
}
