import Factory
import Combine

class PoliticDistrictDetailViewModel: Loadable {
    @Published var loadingState: LoadingState = .initializing
    @Published var organization: PoliticOrganization?
    @Injected(\.organizationRepository) var organizationRepository: OrganizationRepository
    
    @MainActor
    func getOrganization(district: District) async {
        await loadingStateScope {
            organization = try await organizationRepository.findAllBy(page: 0, size: 1, districtId: district.id).first
        }
    }
}


extension Container {
    var politicDistrictDetailViewModel: Factory<PoliticDistrictDetailViewModel> {
        Factory(self) { PoliticDistrictDetailViewModel() }.shared
    }
}
