import Foundation
import SwiftUI


protocol DashboardWidgetWrapper: Identifiable, Hashable, Equatable {
    associatedtype Content: View
    
    var id: String { get set }
    
    var contentView: Content { get }
}
