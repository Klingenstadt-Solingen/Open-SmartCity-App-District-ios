import ParseCore
import OSCAEssentials
import Foundation

class Event : PFObject, PFSubclassing {
    static func parseClassName() -> String {
        "Event"
    }

    @NSManaged var startDate: Date
    @NSManaged var endDate: Date?
    @NSManaged var name: String
    @NSManaged var category: String
    @NSManaged var image: String?
    @NSManaged var url: String?
    @NSManaged var location: String?
    @NSManaged override var description: String
    @NSManaged var geopoint: PFGeoPoint
    @NSManaged var districts: PFRelation<District>
    @NSManaged var type: EventType?
    @NSManaged var sponsors: PFRelation<EventSponsor>
    @NSManaged var eventStatus: String
}
