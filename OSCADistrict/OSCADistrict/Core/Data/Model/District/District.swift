import Foundation
import ParseCore

class District: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        return "District"
    }
    
    @NSManaged var name: String
    @NSManaged var image: PFFileObject
    @NSManaged var logo: PFFileObject
    @NSManaged var area: PFPolygon
    @NSManaged var diashowConfig: SteleDiashowConfig?
}


