
import ParseCore
import OSCAEssentials
import Foundation

class EventTag: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        "EventTag"
    }
    
    @NSManaged var name: String
}
