import Foundation
import MapKit
import OSCAEssentials

class PoiMapViewModel: Loadable {
    @Published var loadingState: LoadingState = .initializing
    @Published var pointOfInterests: [OSCAPointOfInterest] = []

    func requestPois(_ categoryIds: Set<String> = [], districtState : DistrictState) async {
        await loadingStateScope {
            self.pointOfInterests = try await PoiRepositoryImpl.getPois(categories: categoryIds, districtState: districtState)
        }
    }
}
