import SwiftUI
import ParseCore


struct ProjectTileWrapper: DashboardTileWrapper {
    var id: String = UUID().uuidString
    var navigationRoute: Route = Route.project
    
    var contentView: some View {
        ProjectTileView()
    }
}

