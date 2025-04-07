import ParseCore
import CoreLocation

struct WeatherRepositoryImpl: WeatherRepository {
    static func getWeatherById(objectId: String) async -> AsyncThrowingStream<Weather, any Error> {
        let query = Weather.query()!
        query.maxCacheAge = OSCADistrictSettings.shared.shortCacheAge
        query.cachePolicy = .networkElseCache
        
        return streamParse(query, objectId: objectId)
    }
    
    static func getWeathers(skip: Int = 0, limit: Int = 100, districtState: DistrictState) async throws -> [Weather] {
        let query = Weather.query()!
        
        query.whereKey("maintenance", equalTo: false)
        
        query.applyDistrictFilter(districtState: districtState)
        
        query.limit = limit
        query.skip = skip
        query.maxCacheAge = OSCADistrictSettings.shared.shortCacheAge
        query.cachePolicy = .networkElseCache
        
        return try await catchParse { try await query.findObjectsInBackground() }
    }
}
