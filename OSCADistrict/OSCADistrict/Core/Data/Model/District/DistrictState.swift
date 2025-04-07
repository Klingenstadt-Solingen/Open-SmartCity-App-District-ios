import Foundation
import CoreLocation

enum DistrictState: CustomStringConvertible, Equatable, Hashable {
    case all
    case district(_ district: District)
    // Nearby is sorted by current location or current location district
    case nearby(_ location: CLLocation, _ maxDistance: Float)
    
    var description: String {
        switch self {
        case .all:
            return "all"
        case .district(let district):
            return "district(\(district.id))"
        case .nearby(_, let dist):
            return "nearby(\(dist))"
        }
    }
}
