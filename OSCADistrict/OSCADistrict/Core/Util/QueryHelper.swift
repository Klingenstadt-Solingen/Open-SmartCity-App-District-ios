
import ParseCore
import Foundation

extension PFQuery<PFObject> {
    func nearDistrict(key: String, districtState : DistrictState)  {
        var loc : CLLocation;
        var maxDist : Float;
        
        switch (districtState) {
            case .nearby(let location, let maxDistance):
                loc = location;
                maxDist = maxDistance;
                break;
            default: return;
        }
        
        let geoPoint = loc.toPFGeoPoint()
        
        if (Double(maxDist) < OSCADistrictSettings.shared.maxDistanceRange) {
            whereKey(key, nearGeoPoint: geoPoint, withinKilometers: Double(maxDist))
        } else {
            whereKey(key, nearGeoPoint: geoPoint)
        }
    }
    
    func applyDistrictFilter(districtState : DistrictState) {
        switch(districtState) {
        case .all:
            break
        case .district(let district):
            self.whereKey("districts", equalTo: district)
        case .nearby(_, _):
            self.nearDistrict(key: "geopoint", districtState: districtState)
        }
    }
    
    @objc func whereKeyInPolygon(_ key: String, polygon: PFPolygon) {
        self.whereKey("geopoint", withinPolygon: polygon.coordinates())
    }
    
    @objc func findByObjectId(_ objectId: String) async throws -> PFObject {
        skip = 0
        whereKey("objectId", equalTo: objectId)
        return try await firstObjectInBackground() as PFObject
    }
}
