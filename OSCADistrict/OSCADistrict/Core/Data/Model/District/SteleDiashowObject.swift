import Foundation
import ParseCore

class SteleDiashowObject: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        return "SteleDiashowObject"
    }
    
    @NSManaged var name: String?
    @NSManaged var duration: Double
    @NSManaged var endDate: Date?
    @NSManaged var startDate: Date?
    @NSManaged var file: PFFileObject?
    
    func getDescription() -> String? {
        return self.object(forKey: "description") as? String
    }
    
}

