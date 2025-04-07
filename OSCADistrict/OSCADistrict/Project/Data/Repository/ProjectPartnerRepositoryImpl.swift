import ParseCore

struct ProjectPartnerRepositoryImpl: ProjectPartnerRepository {
    static func getProjectPartnersByProjectId(objectId: String) async throws -> [ProjectPartner] {
        let query = Project(withoutDataWithObjectId: objectId).relation(forKey: "partners").query()
        query.cachePolicy = .cacheElseNetwork
        query.maxCacheAge = OSCADistrictSettings.shared.mediumCacheAge
        query.includeKey("category")
        
        return try await catchParse { try await query.findObjectsInBackground() }
    }
}
