
import ParseCore
import Foundation

enum UnknownTypeError : Error {
    case err
}


extension PFPolygon {
    
    /// It is documented on the PFPolygon that its coordinates can be of the following type:
    /// coordinates Array of `CLLocation`, `PFGeoPoint` or `(lat,lng)`
    /// whereas the tuple seems to be not casted by Swift and is detected as a raw NSArray
    func getGeopoints() throws -> [PFGeoPoint] {
        switch (coordinates) {
            case let coords as [PFGeoPoint]:
                return coords;
            case let coords as [CLLocation]:
                return coords.map ({$0.toPFGeoPoint()})
            case let coords as [(Double, Double)]:
                // $.0 and $.1 might be swapped, like in [NSArray] case where the first element is the longitude and not the latitude
                return coords.map({PFGeoPoint(latitude: $0.0, longitude: $0.1)});
            case let points as [NSArray]:
                let coords = points.map({
                    let lng = $0.firstObject as? Double;
                    let lat = $0.lastObject as? Double;
                    
                    return PFGeoPoint(latitude: lat ?? 0, longitude: lng ?? 0)
                });
                
            return coords;
            default:
            throw UnknownTypeError.err;
        }
    }
}
