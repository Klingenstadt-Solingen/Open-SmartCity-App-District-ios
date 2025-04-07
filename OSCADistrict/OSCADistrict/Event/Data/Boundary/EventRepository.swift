import Foundation

protocol EventRepository {
    static func getEventById(_ objectId: String) async throws -> Event
    static func getEventBoothsByEventId(_ objectId: String) async throws -> [EventBooth]
    static func getEvents(
        districtState: DistrictState,
        dateRangeMin: Date?,
        dateRangeMax: Date?,
        limit: Int,
        skip: Int, 
        searchText: String?,
        bookmarkedIds: [String]?
    ) async throws -> [Event]
    static func getNewEventCount(districtState: DistrictState, watchedAt: Date) async -> Int
    static func getEventBoothSponsorsByEventBoothId(_ objectId: String) async throws -> [EventSponsor]
    static func getEventSponsorsByEventId(_ objectId: String) async throws -> [EventSponsor]
    static func getEventOpeningHoursByEventId(_ objectId: String) async throws -> [EventOpeningHour]
}
