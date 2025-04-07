import Foundation
import MapKit


class DistrictPolygon: MKPolygon {
    convenience init(district: District) {
        let coords = district.area.coordinates().map { geo in
            geo.toCLLocationCoordinate2D()
        }
        self.init(coordinates: coords, count: coords.count)
    }
}
