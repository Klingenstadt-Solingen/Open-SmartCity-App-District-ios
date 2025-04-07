import ParseCore


class PoiCategory: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        "POICategory"
    }
    
    @NSManaged var name: String
    @NSManaged var mapTitle: String

    @NSManaged var sourceId: String
    @NSManaged var symbolPath: String
    @NSManaged var symbolName: String
    @NSManaged var symbolMimetype: String
    
    @NSManaged var iconPath: String
    @NSManaged var iconName: String
    @NSManaged var iconMimetype: String
    
    func getImageUrl() -> URL? {
        return URL(string: "\(symbolPath)/\(symbolName)\(symbolMimetype)")
    }
    
    func getIconImageUrl() -> URL? {
        return URL(string: "\(iconPath)/\(iconName)\(iconMimetype)")
    }
}
