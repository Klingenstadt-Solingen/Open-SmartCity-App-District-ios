protocol ProjectPartnerRepository {
    static func getProjectPartnersByProjectId(objectId: String) async throws -> [ProjectPartner]
}
