import SwiftUI

protocol PressReleaseRepository {
    static func getPressReleases(
        districtState: DistrictState,
        skip: Int,
        limit: Int,
        searchText: String?
    ) async throws -> [PressRelease]

    static func getPressReleaseById(_ id: String) async throws  -> PressRelease
    static func getNewPressReleaseCount(districtState: DistrictState, watchedAt: Date) async -> Int
}
