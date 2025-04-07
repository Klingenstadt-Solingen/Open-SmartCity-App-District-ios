import Foundation

class PressReleaseListViewModel: Pageable {
    typealias PageableItemType = PressRelease
    var pageSize: Int = OSCADistrictSettings.shared.parsePaginationStep
    var pagesLoaded: Int = 0
    var pageableId: String? = nil
    @Published var items: [PressRelease] = []
    @Published var loadingState: LoadingState = .initializing
    @Published var debounceSearchText = ""
    @Published var searchText = ""
    var districtState: DistrictState = .all
     
    init() {
       $searchText
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .assign(to: &$debounceSearchText)
    }
    
    func fetchData(skip: Int, limit: Int) async throws -> [PressRelease] {
        return try await PressReleaseRepositoryImpl.getPressReleases(
            districtState: districtState,
            skip: skip,
            limit: limit,
            searchText: debounceSearchText
        )
    }
}

