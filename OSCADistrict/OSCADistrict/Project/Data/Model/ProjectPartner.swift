import ParseCore

open class ProjectPartner: PFObject, PFSubclassing {
    public static func parseClassName() -> String {
        "ProjectPartner"
    }
    
    @NSManaged var name: String
    @NSManaged var image: String
    @NSManaged var category: ProjectPartnerCategory?
    @NSManaged var url: String
        
}
