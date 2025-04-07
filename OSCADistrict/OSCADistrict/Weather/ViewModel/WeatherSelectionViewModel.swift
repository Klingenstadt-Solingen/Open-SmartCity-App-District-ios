import SwiftUI

class WeatherSelectionViewModel: Pageable {
    typealias PageableItemType = Weather
    var pageSize: Int = OSCADistrictSettings.shared.parsePaginationStep
    var pagesLoaded: Int = 0
    var pageableId: String? = nil
    @Published var items: [Weather] = []
    @Published var loadingState: LoadingState = .initializing
    var districtState: DistrictState = .all
    
    func fetchData(skip: Int, limit: Int) async throws -> [Weather] {
        try await WeatherRepositoryImpl.getWeathers(skip: skip, limit: limit, districtState: districtState)
    }
}
