protocol WeatherRepository {
    static func getWeatherById(objectId: String) async -> AsyncThrowingStream<Weather, any Error>
    static func getWeathers(skip: Int, limit: Int, districtState: DistrictState) async throws -> [Weather]
}
