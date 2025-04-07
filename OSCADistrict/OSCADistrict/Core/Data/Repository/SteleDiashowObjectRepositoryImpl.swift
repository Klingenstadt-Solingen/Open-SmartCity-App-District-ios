import ParseCore

struct SteleDiashowObjectRepositoryImpl: SteleDiashowObjectRepository {
    static func getDiashowObjectsByDiashowConfig(_ diashowConfig: SteleDiashowConfig) async throws -> [SteleDiashowObject] {
        let query = diashowConfig.diashowObjects.query()
        query.whereKey("startDate", lessThanOrEqualTo: Date.now)
        query.whereKey("endDate", greaterThanOrEqualTo: Date.now)
        
        query.maxCacheAge = OSCADistrictSettings.shared.longCacheAge
        query.cachePolicy = .networkElseCache
        return try await catchParse(query.findObjectsInBackground)
    }
    static func getDiashowObjectCountByDiashowConfig(_ diashowConfig: SteleDiashowConfig) async -> Int {
        let query = diashowConfig.diashowObjects.query()
        query.whereKey("startDate", lessThanOrEqualTo: Date.now)
        query.whereKey("endDate", greaterThanOrEqualTo: Date.now)
        
        query.maxCacheAge = OSCADistrictSettings.shared.longCacheAge
        query.cachePolicy = .networkElseCache
        do {
            let number: NSNumber = try await catchParse(
                query.countObjectsInBackground
            )
            return number.intValue
        } catch {
            return 0
        }
    }
}
