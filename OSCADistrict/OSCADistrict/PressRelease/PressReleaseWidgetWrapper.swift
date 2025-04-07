import Foundation
import SwiftUI


struct PressReleaseWidgetWrapper: DashboardWidgetWrapper {
    var id: String = UUID().uuidString  
    
    var contentView: some View {
        PressReleaseWidgetView().frame(height: 90)
    }
}
