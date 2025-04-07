import ParseCore

class Project: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        "Project"
    }
    
    @NSManaged var name: String
    @NSManaged var image: String
    @NSManaged var summary: String
    @NSManaged var status: ProjectStatus
    @NSManaged var contacts: PFRelation<ProjectContact>
    @NSManaged var startDate: Date?
    @NSManaged var endDate: Date?
    @NSManaged var content: String
    @NSManaged var districts: PFRelation<District>
    @NSManaged var geopoint: PFGeoPoint?
    @NSManaged var url: String?
    @NSManaged var partners: PFRelation<ProjectPartner>
    @NSManaged var volume: Double
    
}
