import Foundation
import Factory

class PoliticDistrictListViewModel: Pageable {
    typealias PageableItemType = District
    var pageSize: Int = OSCADistrictSettings.shared.parsePaginationStep
    var pagesLoaded: Int = 0
    var pageableId: String? = nil
    @Published var items: [District] = []
    @Published var loadingState: LoadingState = .initializing
    
    func fetchData(skip: Int, limit: Int) async throws -> [District] {
        return try await DistrictRepositoryImpl.getDistricts(skip: skip, limit: limit)
    }
}


extension Container {
    var politicDistrictListViewModel: Factory<PoliticDistrictListViewModel> {
        Factory(self) { PoliticDistrictListViewModel() }.shared
    }
}
