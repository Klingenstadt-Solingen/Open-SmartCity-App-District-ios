import ParseCore
import Foundation

extension CLLocation {

    func toPFGeoPoint() -> PFGeoPoint {
        return PFGeoPoint(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
}
