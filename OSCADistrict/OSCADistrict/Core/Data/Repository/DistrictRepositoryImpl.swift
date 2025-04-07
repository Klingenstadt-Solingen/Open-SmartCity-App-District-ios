import Foundation
import OSCAEssentials


struct DistrictRepositoryImpl: DistrictRepository {
    static func getDistrictById(_ id: String) async throws -> District {
        let query = District.query()!
        query.includeKey("diashowConfig")
        
        query.maxCacheAge = OSCADistrictSettings.shared.longCacheAge
        query.cachePolicy = .cacheElseNetwork
        return try await catchParse { try await query.findByObjectId(id) }
    }
    
    static func getFirstDistrict() async throws -> District {
        let query = District.query()!
        query.includeKey("diashowConfig")
        
        query.maxCacheAge = OSCADistrictSettings.shared.longCacheAge
        query.cachePolicy = .cacheElseNetwork
        return try await catchParse { try await query.firstObjectInBackground() }
    }
    
    static func getDistricts(skip: Int = 0, limit: Int = 100) async throws -> [District] {
        let query = District.query()!
        query.includeKey("diashowConfig")
        
        query.skip = skip
        query.limit = limit
        
        query.maxCacheAge = OSCADistrictSettings.shared.longCacheAge
        query.cachePolicy = .cacheElseNetwork
        return try await catchParse(query.findObjectsInBackground)
    }
}
