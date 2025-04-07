import Foundation
import SwiftUI

struct PointOfInterestWidgetWrapper: DashboardWidgetWrapper {
    var id: String = UUID().uuidString
    
    var contentView: some View {
        PoiWidgetView().frame(height: 90)
    }
}
