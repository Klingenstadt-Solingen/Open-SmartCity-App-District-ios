import Foundation
import ParseCore
import MapKit
import OSCAEssentials


struct PoiRepositoryImpl: PoiRepository {
    static func getPoiById(objectId: String) async throws -> OSCAPointOfInterest {
        let query = OSCAPointOfInterest.query()!
        query.selectKeys(["name", "geopoint", "poiCategory", "details"])

        query.maxCacheAge = OSCADistrictSettings.shared.mediumCacheAge
        query.cachePolicy = .cacheElseNetwork

        return try await catchParse { try await query.findByObjectId(objectId) }
    }

    static func getPois(categories: Set<String>, districtState: DistrictState) async throws -> [OSCAPointOfInterest] {
        let query = OSCAPointOfInterest.query()!
        query.selectKeys(["name", "geopoint", "poiCategory"])
        query.whereKey("poiCategory", containedIn: Array(categories))
        query.maxCacheAge = OSCADistrictSettings.shared.longCacheAge
        query.cachePolicy = .cacheElseNetwork
        query.limit = 4000
        
        applyDistrictFilter(query: query, districtState: districtState);
        
        return try await catchParse { try await query.findObjectsInBackground() }
    }
    
    // needed until pois get districts relation
    private static func applyDistrictFilter(query: PFQuery<PFObject>, districtState : DistrictState) {
        switch(districtState) {
        case .all:
            break
        case .district(let district):
            do {
                let points = try district.area
                query.whereKeyInPolygon("geopoint", polygon: points)
            } catch (_) {}
        case .nearby(_, _):
            query.nearDistrict(key: "geopoint", districtState: districtState)
        }
    }
}
