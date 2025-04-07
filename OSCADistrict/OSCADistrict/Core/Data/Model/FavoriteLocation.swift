import ParseCore
import OSCAEssentials
import Foundation

class FavoriteLocation: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        "FavoriteLocation"
    }
    
    @NSManaged var name: String
    @NSManaged var geopoint: PFGeoPoint
    @NSManaged var tags: NSArray
    
    static func createFrom(name: String, geopoint: PFGeoPoint, tags: [String]) -> FavoriteLocation {
        let favoriteLocation = FavoriteLocation()
        favoriteLocation["name"] = name
        favoriteLocation["geopoint"] = geopoint
        if let tags = tags as? NSArray {
            favoriteLocation["tags"] = tags
        }
        
        return favoriteLocation
    }
}
