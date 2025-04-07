import ParseCore

struct ProjectContactRepositoryImpl: ProjectContactRepository {
    static func getProjectContactsByProjectId(objectId: String) async throws -> [ProjectContact] {
        let query = Project(withoutDataWithObjectId: objectId).relation(forKey: "contacts").query()
        query.cachePolicy = .cacheElseNetwork
        query.maxCacheAge = OSCADistrictSettings.shared.mediumCacheAge
        
        return try await catchParse(query.findObjectsInBackground)
    }
}
