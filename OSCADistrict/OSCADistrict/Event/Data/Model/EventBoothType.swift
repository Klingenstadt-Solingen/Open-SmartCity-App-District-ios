import ParseCore
import OSCAEssentials
import Foundation

class EventBoothType: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        "EventBoothType"
    }
    
    @NSManaged var name: String
    @NSManaged var icon: PFFileObject
}
