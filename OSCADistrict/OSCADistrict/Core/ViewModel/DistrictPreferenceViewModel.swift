import Foundation


class DistrictPreferenceViewModel: Loadable {
    @Published var loadingState: LoadingState = .initializing
    @Published var districts: [District] = []
    
    
    func getDistricts() async {
        await loadingStateScope {
            let districts = try await DistrictRepositoryImpl.getDistricts()
            
            await MainActor.run {
                self.districts = districts
            }
        }
    }
}
