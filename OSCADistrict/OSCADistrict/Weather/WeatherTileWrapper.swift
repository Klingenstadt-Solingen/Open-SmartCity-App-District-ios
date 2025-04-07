import SwiftUI

struct WeatherTileWrapper: DashboardTileWrapper {
    var id: String = UUID().uuidString
    var navigationRoute: Route = .weather
    
    var contentView: some View {
        WeatherTileView()
    }
}
