import ParseCore
import OSCAEssentials
import Foundation

class EventOpeningHour: PFObject, PFSubclassing{
    static func parseClassName() -> String {
        "EventOpeningHour"
    }
    
    @NSManaged var startTime: Date
    @NSManaged var endTime: Date
}
