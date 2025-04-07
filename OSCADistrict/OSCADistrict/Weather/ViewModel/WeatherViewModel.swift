import SwiftUI

class WeatherViewModel: Loadable {
    @Published var loadingState: LoadingState = .initializing
    @Published var selectedWeather: Weather?
    
    @AppStorage("selectedWeatherId") public private(set) var selectedWeatherId: String?
    
    func getWeather() async {
        await MainActor.run {
            loadingState = .initializing
            selectedWeather = nil
        }
        
        if let weatherId = selectedWeatherId {
            do {
                let selectedWeatherStream = await WeatherRepositoryImpl.getWeatherById(objectId: weatherId)
                for try await selectedWeather in selectedWeatherStream {
                    await MainActor.run {
                        self.selectedWeather = selectedWeather
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
    
    func changeSelectedWeather(_ weather: Weather?) {
        selectedWeather = weather
        if weather != nil {
            selectedWeatherId = weather?.objectId
        }
    }
}

let preselectedMeasurementCategories = [
    "lufttemperatur",
    "realtiver_luftdruck_avg",
    "niederschlagsintensitaet_avg",
    "windgeschwindigkeit_kmh_avg",
    "windrichtung_avg",
    "globalstrahlung_avg"
]

let weatherIconDictionary: Dictionary<String,String> = [
    "Luftdruck" : "ic_pressure_sensor",
    "Niederschlag" : "ic_cloud",
    "Windgeschwindigkeit" : "ic_cloud_wind",
    "Windrichtung" : "ic_wind_direction",
    "Globalstrahlung" : "ic_radiation_sensor",
    "Temperatur" : "ic_temperature"
]
