import SwiftUI

class MobilityAddressViewModel: Pageable {
    typealias PageableItemType = FavoriteLocation
    var pageSize: Int = OSCADistrictSettings.shared.parsePaginationStep
    var pagesLoaded: Int = 0
    var pageableId: String? = nil
    @Published var loadingState: LoadingState = .initializing
    @Published var items: [FavoriteLocation] = []
    @Published var debounceSearchText = ""
    @Published var searchText = ""
    @Published var poiAddresses: [POIAddress] = []
    @Published var addressLoadingState: LoadingState = .initializing
    
    init() {
        $searchText
            .debounce(for: .seconds(0.3), scheduler: RunLoop.main)
            .assign(to: &$debounceSearchText)
    }
    
    func fetchData(skip: Int, limit: Int) async throws -> [FavoriteLocation] {
        return try await FavoriteLocationRepositoryImpl.getFavoriteLocations(skip: skip, limit: limit)
    }
    
    func fetchAddresses() async {
        await MainActor.run {
            addressLoadingState = .initializing
            poiAddresses = []
        }
        do {
            let newPoiAddresses = try await POIAddressRepositoryImpl.getAddresses(
                searchText: debounceSearchText, limit: 10, skip: 5
            )
            await MainActor.run {
                poiAddresses = newPoiAddresses
                addressLoadingState = .loaded
            }
        } catch {
            addressLoadingState = .error(errorMessage: "no_result")
        }
    }
}
