import Foundation
import MapKit

extension MKCoordinateRegion: Equatable {
    public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        return lhs.center.latitude == rhs.center.latitude &&
            lhs.center.longitude == rhs.center.longitude &&
            lhs.span.longitudeDelta == rhs.span.longitudeDelta &&
            lhs.span.latitudeDelta == rhs.span.latitudeDelta
    }
}
