import Foundation
import SwiftUI


struct MobilityTileWrapper: DashboardTileWrapper {
    var id: String = UUID().uuidString
    var navigationRoute: Route = Route.mobility
    
    var contentView: some View {
        DashboardDefaultTile(
            title: "mobility_title",
            image: "ic_car"
        )
    }
}
