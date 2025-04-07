import Foundation
import Combine
import Factory

class PoliticMemberDetailViewModel : Pageable {
    @Injected(\.membershipRepository) var membershipRepository: MembershipRepository
    typealias PageableItemType = PoliticMembership
    var pageSize: Int = OSCADistrictSettings.shared.politicPaginationStep
    var pagesLoaded: Int = 0
    var pageableId: String? = nil
    @Published var items: [PoliticMembership] = []
    @Published var loadingState: LoadingState = .initializing
    var personId: String = ""
    
    func fetchData(skip: Int, limit: Int) async throws -> [PoliticMembership] {
        try await membershipRepository.findAllBy(page: skip / limit, size: limit, organizationId: nil, personId: personId)
    }
}

extension Container {
    var politicMemberDetailViewModel: Factory<PoliticMemberDetailViewModel> {
        Factory(self) { PoliticMemberDetailViewModel() }.shared
    }
}
