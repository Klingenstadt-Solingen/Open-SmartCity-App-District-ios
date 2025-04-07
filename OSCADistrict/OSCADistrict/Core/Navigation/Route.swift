import Foundation


enum Route: Hashable, Equatable {
    case pressReleases
    case pressReleaseDetail(_ objectId: String)

    case event
    case eventDetail(_ objectId: String)
    case eventMapDetail(_ objectId: String)

    case project
    case projectDetail(_ objectId: String)

    case weather
    
    case mobility
    case mobilityVehicleDetailScreen(_ objectId: String)
    case mobilityStationDetailScreen(_ objectId: String)

    case poiMap(_ categoryId: String? = nil)

    case politicDistricts
    case politicDistrictDetail(_ district: District)

    case politicMeetings(_ organizationId: String, title: String)
    case politicMeetingDetail(_ meeting: PoliticMeeting)

    case politicMembers(_ organizationId: String, title: String)
    case politicMemberDetail(_ membership: PoliticMembership)
    
    case districtDiashow
    
    case standaloneRoute
    
    var description: String {
        switch(self) {
        case .pressReleases:
            "pressreleases"
        case .pressReleaseDetail(let objectId):
            "detail?objectId=\(objectId)"
        case .event:
            "events"
        case .eventDetail(let objectId):
            "detail?objectId=\(objectId)"
        case .eventMapDetail(let objectId):
            "map?objectId=\(objectId)"
        case .project:
            "projects"
        case .projectDetail(let objectId):
            "detail?objectId=\(objectId)"
        case .weather:
            "weather"
        case .poiMap(let categoryId):
            "poi" + (categoryId != nil ? "?categoryId=\(categoryId)" : "")
        /*case politicDistricts:
            "politics"
        case politicDistrictDetail(_ district: District):
            ""
        case politicMeetings(_ organizationId: String, title: String)
        case politicMeetingDetail(_ meeting: PoliticMeeting)

        case politicMembers(_ organizationId: String, title: String)
        case politicMemberDetail(_ membership: PoliticMembership)
        
        case districtDiashow*/
        default:
            "nd"
        }
    }
}
