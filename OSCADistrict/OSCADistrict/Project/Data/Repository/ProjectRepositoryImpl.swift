import ParseCore

struct ProjectRepositoryImpl: ProjectRepository {
    
    static func getNewProjectCount(districtState: DistrictState, watchedAt: Date) async -> Int {
        let query = Project.query()!
    
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
    
    static func getProjectById(objectId: String) async throws -> Project {
        let query = Project.query()!
        query.includeKey("status")
        query.cachePolicy = .cacheElseNetwork
        query.maxCacheAge = OSCADistrictSettings.shared.mediumCacheAge
        
        return try await catchParse { try await query.findByObjectId(objectId) }
    }
    
    static func getProjects(
        districtState: DistrictState = .all,
        skip: Int = 0,
        limit: Int = 100,
        searchText: String? = nil,
        status: ProjectStatus? = nil
    ) async throws -> [Project] {
        var query = Project.query()!
        
        if let searchText = searchText, !searchText.isEmpty {
            query = PFQuery.orQuery(withSubqueries: [
                query.whereKey("name", contains: searchText),
                Project.query()!.whereKey("summary", contains: searchText)
            ])
        }
        
        if let status {
            query = query.whereKey("status", equalTo: status.objectId!)
        }
        
        query.applyDistrictFilter(districtState: districtState);
        
        query.skip = skip
        query.limit = limit
        query.includeKey("status")
        query.cachePolicy = .networkElseCache
        query.maxCacheAge = OSCADistrictSettings.shared.mediumCacheAge
       
        return try await catchParse(query.findObjectsInBackground)
    }
    
    static func getProjectStatus() async throws -> [ProjectStatus] {
        var query = ProjectStatus.query()!;
        query.cachePolicy = .networkElseCache
        query.maxCacheAge = OSCADistrictSettings.shared.mediumCacheAge
        
        return try await catchParse(query.findObjectsInBackground)
    }
}
