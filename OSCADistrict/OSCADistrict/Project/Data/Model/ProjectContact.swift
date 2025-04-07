import ParseCore

class ProjectContact: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        "ProjectContact"
    }
    
    @NSManaged var name: String
    @NSManaged var image: String
    @NSManaged var phoneNumber: String
    @NSManaged var email: String
    @NSManaged var organization: String
}
