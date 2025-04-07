struct POIAddressRepositoryImpl: POIAddressRepository {
    static func getAddresses(searchText: String? = nil, limit: Int = 10, skip: Int = 0) async throws -> [POIAddress] {
        let query = POIAddress.query()!
        
        if let searchText = searchText {
            query.whereKey("concatAddress", contains: searchText)
        }
        
        query.maxCacheAge = OSCADistrictSettings.shared.mediumCacheAge
        query.cachePolicy = .networkElseCache
        
        return try await catchParse(query.findObjectsInBackground)
    }
}
