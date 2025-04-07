import Foundation
import ParseCore

class SteleDiashowConfig: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        return "SteleDiashowConfig"
    }
    
    @NSManaged var name: String?
    @NSManaged var diashowObjects: PFRelation<SteleDiashowObject>
    
    func getDescription() -> String? {
        return self.object(forKey: "description") as? String
    }
}
