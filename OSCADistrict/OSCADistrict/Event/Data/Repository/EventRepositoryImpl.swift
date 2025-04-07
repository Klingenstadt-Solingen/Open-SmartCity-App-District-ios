import ParseCore

struct EventRepositoryImpl: EventRepository {
    static func getNewEventCount(
        districtState: DistrictState = .all,
        watchedAt: Date
    ) async -> Int {
        let queryEnd = Event.query()!
        let queryNoEnd = Event.query()!
        
        let earlyDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date.now)!
        let lateDate = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: Date.now)!
        
        queryEnd.whereKey("startDate", lessThan: lateDate)
        queryEnd.whereKey("endDate", greaterThan: Date.now)
        
        queryNoEnd.whereKey("startDate", greaterThan: earlyDate)
        queryNoEnd.whereKey("startDate", lessThan: lateDate)
        queryNoEnd.whereKeyDoesNotExist("endDate")
        
        let query = PFQuery.orQuery(withSubqueries: [queryNoEnd, queryEnd])
        query.whereKey("updatedAt", greaterThan: watchedAt)
        query.includeKey("type")
        query.whereKey("eventStatus", containedIn: ["scheduled","postponed","canceled"])
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
    
    static func getNextEvents(
        districtState: DistrictState = .all,
        limit: Int = 50
    ) async throws -> [Event] {
        let queryEnd = Event.query()!
        let queryNoEnd = Event.query()!
        
        let earlyDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date.now)!
        let lateDate = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: Date.now)!
        
        queryEnd.whereKey("startDate", lessThan: lateDate)
        queryEnd.whereKey("endDate", greaterThan: Date.now)
        
        queryNoEnd.whereKey("startDate", greaterThan: earlyDate)
        queryNoEnd.whereKey("startDate", lessThan: lateDate)
        queryNoEnd.whereKeyDoesNotExist("endDate")
        
        let query = PFQuery.orQuery(withSubqueries: [queryNoEnd, queryEnd])
        
        query.includeKey("type")
        
        query.order(byAscending: "startDate")
        let typeQuery = EventType.query()!
        typeQuery.whereKey("name", contains: "Großveranstaltung")
        query.whereKey("type", matchesQuery: typeQuery)
        query.limit = limit
        query.whereKey("eventStatus", containedIn: ["scheduled","postponed","canceled"])
        query.maxCacheAge = OSCADistrictSettings.shared.mediumCacheAge
        query.cachePolicy = .networkElseCache
        return try await catchParse(query.findObjectsInBackground)
    }
    
    static func getEventById(_ objectId: String) async throws -> Event {
        let query = Event.query()!
        query.includeKey("type")
        query.maxCacheAge = OSCADistrictSettings.shared.mediumCacheAge
        query.cachePolicy = .networkElseCache
        return try await catchParse { try await query.findByObjectId(objectId) }
    }
    
    static func getEventBoothsByEventId(_ objectId: String) async throws -> [EventBooth] {
        let query = EventBooth.query()!
        query.whereKey("event", equalTo: PFObject(withoutDataWithClassName: "Event", objectId: objectId))
        query.includeKey("type")
        query.includeKey("mainSponsor")
        query.maxCacheAge = OSCADistrictSettings.shared.mediumCacheAge
        query.cachePolicy = .networkElseCache
        return try await catchParse(query.findObjects)
    }
    
    static func getEventTagsByEventBoothId(_ objectId: String) async throws -> [EventTag] {
        let query = EventBooth(withoutDataWithObjectId: objectId).relation(forKey: "tags").query()
        query.maxCacheAge = OSCADistrictSettings.shared.mediumCacheAge
        query.cachePolicy = .networkElseCache
        return try await catchParse(query.findObjects)
    }
    
    static func getEventBoothSponsorsByEventBoothId(_ objectId: String) async throws -> [EventSponsor] {
        let query = EventBooth(withoutDataWithObjectId: objectId).relation(forKey: "sponsors").query()
        query.maxCacheAge = OSCADistrictSettings.shared.mediumCacheAge
        query.cachePolicy = .networkElseCache
        return try await catchParse(query.findObjects)
    }
    
    static func getEventSponsorsByEventId(_ objectId: String) async throws -> [EventSponsor] {
        let query = Event(withoutDataWithObjectId: objectId).relation(forKey: "sponsors").query()
        query.maxCacheAge = OSCADistrictSettings.shared.mediumCacheAge
        query.cachePolicy = .networkElseCache
        return try await catchParse(query.findObjects)
    }
    
    static func getEventOpeningHoursByEventId(_ objectId: String) async throws -> [EventOpeningHour] {
        let query = EventOpeningHour.query()!
        query.whereKey("event", equalTo: PFObject(withoutDataWithClassName: "Event", objectId: objectId))
        query.maxCacheAge = OSCADistrictSettings.shared.mediumCacheAge
        query.cachePolicy = .networkElseCache
        return try await catchParse(query.findObjects)
    }
    
    static func getEvents(
        districtState: DistrictState = .all,
        dateRangeMin: Date?,
        dateRangeMax: Date?,
        limit: Int = 50,
        skip: Int = 0,
        searchText: String? = nil,
        bookmarkedIds: [String]? = nil
    ) async throws -> [Event] {
        var query: PFQuery<PFObject>
        
        if let dateRangeMin = dateRangeMin, let dateRangeMax = dateRangeMax {
            let queryNoEnd = Event.query()!
            let queryEnd = Event.query()!
            
            let earlyDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: dateRangeMin)!
            let lateDate = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: dateRangeMax)!
            
            queryNoEnd.whereKey("startDate", greaterThanOrEqualTo: earlyDate)
            queryNoEnd.whereKey("startDate", lessThanOrEqualTo: lateDate)
            queryNoEnd.whereKeyDoesNotExist("endDate")
            
            queryEnd.whereKey("startDate", lessThanOrEqualTo: lateDate)
            if Date.now.isSameDay(dateRangeMin) {
                queryEnd.whereKey("endDate", greaterThanOrEqualTo: Date.now)
            } else {
                queryEnd.whereKey("endDate", greaterThanOrEqualTo: earlyDate)
            }
            
            query = PFQuery.orQuery(withSubqueries: [queryNoEnd, queryEnd])
        } else {
            query = Event.query()!
        }
        if let searchText = searchText, !searchText.isEmpty {
            query.whereKey("name", contains: searchText)
        }
       
        query.order(byAscending: "startDate")
        
        
        if let bookmarkedIds = bookmarkedIds {
            query.whereKey("objectId", containedIn: bookmarkedIds)
        }
        query.whereKey("eventStatus", containedIn: ["scheduled","postponed","canceled"])
        query.includeKey("type")
        query.applyDistrictFilter(districtState: districtState)
        
        query.maxCacheAge = OSCADistrictSettings.shared.mediumCacheAge
        
        query.limit = limit
        query.skip = skip
        
        query.cachePolicy = .networkElseCache
        
        return try await catchParse(query.findObjectsInBackground)
    }
}
