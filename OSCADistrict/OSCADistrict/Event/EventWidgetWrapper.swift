import Foundation
import SwiftUI


struct EventWidgetWrapper: DashboardWidgetWrapper {
    var id: String = UUID().uuidString
    
    var contentView: some View {
        EventWidgetView().frame(height: 180)
    }
}
