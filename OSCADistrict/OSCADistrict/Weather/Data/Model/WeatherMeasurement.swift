class WeatherMeasurement: Codable {
    var name: String
    var unit: String
    var value: Double
    
    static func getTemperature(_ measurements: [WeatherMeasurement]?) -> WeatherMeasurement? {
        var temperatur: WeatherMeasurement?
        measurements?.forEach() { measurement in
            if measurement.name == "Temperatur" {
                temperatur = measurement
            }
        }
        return temperatur
    }
}
