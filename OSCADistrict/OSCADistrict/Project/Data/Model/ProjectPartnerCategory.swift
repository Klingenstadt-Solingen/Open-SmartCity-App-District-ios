import Foundation
import SwiftUI
import ParseCore

open class ProjectPartnerCategory: PFObject, PFSubclassing {
    public static func parseClassName() -> String {
        "ProjectPartnerCategory"
    }
    
    @NSManaged var title: String

    public func localizedStringKey() -> LocalizedStringKey {
        return LocalizedStringKey(title);
    }
}
