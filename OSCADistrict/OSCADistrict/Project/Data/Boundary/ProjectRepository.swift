import Foundation

protocol ProjectRepository {
    static func getNewProjectCount(districtState: DistrictState, watchedAt: Date) async -> Int
    static func getProjectById(objectId: String) async throws -> Project
    static func getProjects(districtState: DistrictState, skip: Int, limit: Int, searchText: String?, status: ProjectStatus?) async throws -> [Project]
    static func getProjectStatus() async throws -> [ProjectStatus]
}
