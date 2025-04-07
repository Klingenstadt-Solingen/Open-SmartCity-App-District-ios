import Foundation
import Combine
import Factory

class PoliticMemberListViewModel : Pageable {
    @Injected(\.membershipRepository) var membershipRepository: MembershipRepository
    typealias PageableItemType = PoliticMembership
    var pageSize: Int = OSCADistrictSettings.shared.politicPaginationStep
    var pagesLoaded: Int = 0
    var pageableId: String? = nil
    @Published var items: [PoliticMembership] = []
    @Published var loadingState: LoadingState = .initializing
    var organizationId: String = ""
    
    func fetchData(skip: Int, limit: Int) async throws -> [PoliticMembership] {
        return try await membershipRepository.findAllBy(page: skip / pageSize, size: pageSize, organizationId: organizationId, personId: nil)
    }
}

extension Container {
    var politicMemberListViewModel: Factory<PoliticMemberListViewModel> {
        Factory(self) { PoliticMemberListViewModel() }.shared
    }
}
