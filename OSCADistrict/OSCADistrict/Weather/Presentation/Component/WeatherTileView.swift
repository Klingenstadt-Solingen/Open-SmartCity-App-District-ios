import SwiftUI

struct WeatherTileView: View {
    @StateObject var weatherTileVM = WeatherTileViewModel()
    
    var body: some View {
        DashboardDefaultTile(title: "weather_title", image: "ic_cloud") {
            HStack(alignment: .firstTextBaseline, spacing: 0) {
                if let selectedTemperature = weatherTileVM.selectedTemperature {
                    Text("\(selectedTemperature.value, specifier: "%.0f")")
                        .font(.system(size: 30).bold())
                        .fixedSize()
                    Text(selectedTemperature.unit)
                        .font(.system(size: 20).bold())
                        .fixedSize()
                }
            }
            .foregroundColor(Color.primary)
        }.task {
            await weatherTileVM.getWeather()
        }
    }
}
