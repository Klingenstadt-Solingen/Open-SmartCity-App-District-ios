import ParseCore

class Weather: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        "WeatherObserved"
    }
    
    @NSManaged var name: String?
    @NSManaged var shortName: String?
    @NSManaged var image: String?
    @NSManaged var geopoint: PFGeoPoint?
    @NSManaged var values: NSObject
    @NSManaged var dateObserved: Date?
    
    func getValues() -> [WeatherMeasurement] {
        if let decodedValues = try? JSONDecoder().decode(Dictionary<String,WeatherMeasurement>.self, from: JSONSerialization.data(withJSONObject: values)) {
            var measurements: [WeatherMeasurement] = []
            
            preselectedMeasurementCategories.forEach() { category in //TODO: Temporary filter
                decodedValues.forEach() { measurement in
                    if measurement.key == category {
                        measurements.append(measurement.value)
                    }
                }
            }
            
            return measurements
        } else {
            return []
        }
    }
}
