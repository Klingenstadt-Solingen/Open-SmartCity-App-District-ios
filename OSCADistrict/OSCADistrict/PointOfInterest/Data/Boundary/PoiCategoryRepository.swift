protocol PoiCategoryRepository {
    static func getPoiCategories() async throws -> [PoiCategory]
}
