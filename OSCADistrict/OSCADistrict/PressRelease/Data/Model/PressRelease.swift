import Foundation
import ParseCore

class PressRelease: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        return "PressRelease"
    }
    
    @NSManaged var title: String
    @NSManaged var summary: String?
    @NSManaged var content: String
    @NSManaged var date: Date
    @NSManaged var readingTime: Int
    @NSManaged var url: String?
    @NSManaged var imageUrl: String?
    
    @NSManaged var districts: PFRelation<District>
}
