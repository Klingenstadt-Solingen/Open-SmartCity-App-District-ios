import Foundation
import MapKit
import OSCAEssentials

class PoiDetailViewModel: Loadable {
    @Published var loadingState: LoadingState = .initializing
    @Published var pointOfInterest: OSCAPointOfInterest? = nil
    
    func requestPoiById(_ objectId: String) async {
        await loadingStateScope {
            self.pointOfInterest = try await PoiRepositoryImpl.getPoiById(objectId: objectId)
        }
    }
}
