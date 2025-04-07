import ParseCore
import OSCAEssentials
import Foundation

class EventBooth: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        "EventBooth"
    }
    
    @NSManaged var name: String
    @NSManaged var geopoint: PFGeoPoint
    @NSManaged var locationDescription: String
    @NSManaged var area: PFPolygon
    @NSManaged var content: String?
    @NSManaged var type: EventBoothType?
    @NSManaged var mainSponsor: EventSponsor
    @NSManaged var sponsors: PFRelation<EventSponsor>
}
