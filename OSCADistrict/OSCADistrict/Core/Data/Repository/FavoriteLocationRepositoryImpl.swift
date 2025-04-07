import Foundation
import OSCAEssentials
import ParseCore

struct FavoriteLocationRepositoryImpl: FavoriteLocationRepository {
    static func getFavoriteLocations(_ tag: String? = nil, skip: Int = 0, limit: Int = 100) async throws -> [FavoriteLocation] {
        let query = FavoriteLocation.query()!
        if let tag = tag {
            query.whereKey("tags", contains: tag)
        }
        
        query.skip = skip
        query.limit = limit
        
        query.maxCacheAge = OSCADistrictSettings.shared.longCacheAge
        query.cachePolicy = .networkElseCache
        query.order(byDescending: "createdAt")
        
        return try await catchParse(query.findObjectsInBackground)
    }
    
    static func addFavoriteLocation(_ favoriteLocation: FavoriteLocation) async throws {
        if let user = PFUser.current() {
            favoriteLocation.acl = PFACL(user: user)
            try await favoriteLocation.saveInBackground()
        }
    }
    
    static func removeFavoriteLocation(_ favoriteLocation: FavoriteLocation) async throws {
        try await favoriteLocation.deleteInBackground()
    }
}
