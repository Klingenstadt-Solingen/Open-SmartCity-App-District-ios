import SwiftUI

class WeatherTileViewModel: Loadable {
    @Published var loadingState: LoadingState = .initializing
    @Published var selectedTemperature: WeatherMeasurement?
    
    @AppStorage("selectedWeatherId") public private(set) var selectedWeatherId: String?
    
    func getWeather() async {
        await MainActor.run {
            loadingState = .initializing
            selectedTemperature = nil
        }
        if let weatherId = selectedWeatherId {
            do {
                let selectedWeatherStream = await WeatherRepositoryImpl.getWeatherById(objectId: weatherId)
                for try await selectedWeather in selectedWeatherStream {
                    await MainActor.run {
                        selectedTemperature = WeatherMeasurement.getTemperature(selectedWeather.getValues())
                        loadingState = .loaded
                    }
                }
            } catch {
                await MainActor.run {
                    selectedWeatherId = nil
                }
            }
        } else {
            await MainActor.run {
                loadingState = .loaded
            }
        }
    }
}
