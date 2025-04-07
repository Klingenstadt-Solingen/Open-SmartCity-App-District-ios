import ParseCore

class POIAddress : PFObject, PFSubclassing {
    static func parseClassName() -> String {
        "POIAddress"
    }

    @NSManaged var concatAddress: String
    @NSManaged var geopoint: PFGeoPoint
}
