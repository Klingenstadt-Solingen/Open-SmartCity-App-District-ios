import Foundation
import SwiftUI


struct PointOfInterestTileWrapper: DashboardTileWrapper {
    
    var id: String = UUID().uuidString
    var navigationRoute: Route = Route.poiMap()
    
    var contentView: some View {
        DashboardDefaultTile(title: "point_of_interest_title", image: "ic_map_with_marker")
    }
}
