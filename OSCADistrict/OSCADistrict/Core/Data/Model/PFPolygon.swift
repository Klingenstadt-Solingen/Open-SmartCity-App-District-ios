import Foundation
import ParseCore


extension PFPolygon {
    func coordinates() -> [PFGeoPoint] {
        var geopoints: [PFGeoPoint] = []
        if let castedGeopoints = self.coordinates as? [[Double]] {
            castedGeopoints.forEach() { point in
                geopoints.append(PFGeoPoint(latitude: point[0], longitude: point[1]))
            }
        }
        return geopoints
    }
}
