import Foundation
import MapKit
import OSCAEssentials

protocol PoiRepository {
    static func getPoiById(objectId: String) async throws -> OSCAPointOfInterest
    

    static func getPois(categories: Set<String>, districtState : DistrictState) async throws -> [OSCAPointOfInterest]
        
}
