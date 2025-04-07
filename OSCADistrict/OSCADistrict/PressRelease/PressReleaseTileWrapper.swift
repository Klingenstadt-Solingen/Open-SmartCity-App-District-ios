import Foundation
import SwiftUI


struct PressReleaseTileWrapper: DashboardTileWrapper {
    var id: String = UUID().uuidString
    var navigationRoute: Route = Route.pressReleases
    
    var contentView: some View {
        PressReleaseTileView()
    }
}
