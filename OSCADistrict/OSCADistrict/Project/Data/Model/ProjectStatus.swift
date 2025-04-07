import Foundation
import SwiftUI
import ParseCore

open class ProjectStatus: PFObject, PFSubclassing {
    public static func parseClassName() -> String {
        "ProjectStatus"
    }
    
    @NSManaged var title: String
    
    static func titleOf(status: ProjectStatus?) -> LocalizedStringKey {
        return status != nil ? LocalizedStringKey(status!.title) : "all_status"
    }
}

/*
enum ProjectStatus: String, Equatable, CaseIterable {
    case all, idea, planning, realization, completed, unknown
    
    public func localizedStringKey() -> LocalizedStringKey {
        switch self {
        case .all:
            return "all_status"
        case .idea:
            return "idea_status"
        case .planning:
            return "planning_status"
        case .realization:
            return "realization_status"
        case .completed:
            return "completed_status"
        default:
            return "unknown_status"
        }
    }
}
*/
