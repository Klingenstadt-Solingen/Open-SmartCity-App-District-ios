
import ParseCore
import OSCAEssentials
import Foundation

class EventSponsor: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        "EventSponsor"
    }
    
    @NSManaged var name: String
    @NSManaged public var icon: PFFileObject
}
