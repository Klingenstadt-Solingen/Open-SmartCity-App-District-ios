import Foundation
import SwiftUI


struct EventTileWrapper: DashboardTileWrapper {
    var id: String = UUID().uuidString
    var navigationRoute: Route = Route.event
    
    var contentView: some View {
        EventTileView()
    }
}

