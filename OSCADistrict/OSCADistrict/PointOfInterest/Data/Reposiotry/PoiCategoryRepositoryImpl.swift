import ParseCore

struct PoiCategoryRepositoryImpl: PoiCategoryRepository {
    static func getPoiCategories() async throws -> [PoiCategory] {
        let query = PoiCategory.query()!.order(byAscending: "position")
        query.whereKey("showCategory", equalTo: "true")

        query.maxCacheAge = OSCADistrictSettings.shared.longCacheAge
        query.cachePolicy = .cacheElseNetwork
        
        return try await catchParse { try await query.findObjectsInBackground() }
    }
}
