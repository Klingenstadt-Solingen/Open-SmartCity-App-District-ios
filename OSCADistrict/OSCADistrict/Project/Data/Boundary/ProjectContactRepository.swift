protocol ProjectContactRepository {
    static func getProjectContactsByProjectId(objectId: String) async throws -> [ProjectContact]
}
