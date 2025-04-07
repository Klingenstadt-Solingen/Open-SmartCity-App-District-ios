import ParseCore
import OSCAEssentials
import Foundation

class EventType: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        "EventType"
    }
    
    @NSManaged var name: String
}
