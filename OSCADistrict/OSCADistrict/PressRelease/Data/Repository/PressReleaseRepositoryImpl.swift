import Foundation
import ParseCore

struct PressReleaseRepositoryImpl: PressReleaseRepository {
    static func getNewPressReleaseCount(districtState: DistrictState, watchedAt: Date) async -> Int {
        let query = PressRelease.query()!
        query.whereKey("updatedAt", greaterThan: watchedAt)
        
        if case .district(let district) = districtState {
            query.whereKey("districts", equalTo: district)
        }
        
        query.maxCacheAge = OSCADistrictSettings.shared.mediumCacheAge
        query.cachePolicy = .networkElseCache
        
        do {
            let count: NSNumber = try await catchParse(query.countObjectsInBackground)
            return Int(count)
        } catch {
            return .zero
        }
    }
    
    static func getPressReleases(
        districtState: DistrictState = .all,
        skip: Int = 0,
        limit: Int = 5,
        searchText: String? = nil
    ) async throws -> [PressRelease] {
        var query = PressRelease.query()!
        
        if let searchText = searchText, !searchText.isEmpty {
            query = PFQuery.orQuery(withSubqueries: [
                query.whereKey("title", contains: searchText),
                PressRelease.query()!.whereKey("summary", contains: searchText)
            ])
        }
        if case .nearby(_, _) = districtState {} else {
            query.order(byDescending: "date")
        }
        
        query.applyDistrictFilter(districtState: districtState)
        
        query.skip = skip
        query.limit = limit
        
        query.maxCacheAge = OSCADistrictSettings.shared.mediumCacheAge
        query.cachePolicy = .networkElseCache
        
        return try await catchParse(query.findObjectsInBackground)
    }
    
    static func getPressReleaseById(_ id: String) async throws  -> PressRelease {
        let query = PressRelease.query()!
        query.maxCacheAge = OSCADistrictSettings.shared.mediumCacheAge
        query.cachePolicy = .cacheElseNetwork
        
        return try await catchParse { try await query.findByObjectId(id) }
    }
}
