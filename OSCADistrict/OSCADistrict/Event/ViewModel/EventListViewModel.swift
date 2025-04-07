import Foundation

class EventListViewModel: Pageable {
    typealias PageableItemType = Event
    var pageSize: Int = OSCADistrictSettings.shared.parsePaginationStep
    var pagesLoaded: Int = 0
    var pageableId: String? = nil
    @Published var items: [Event] = []
    @Published var loadingState: LoadingState = .initializing
    @Published var showFilterPicker = false
    @Published var selectedRangeMin = Date.now
    @Published var selectedRangeMax = Date.now
    @Published var debounceSearchText = ""
    @Published var searchText = ""
    @Published var filterTypes: Set<FilterType> = [.Day]
    var districtState: DistrictState = .all
    var eventBookmarks: [String]? = nil
    
    init() {
        $searchText
            .debounce(for: .seconds(0.1), scheduler: RunLoop.main)
            .assign(to: &$debounceSearchText)
    }
    
    func fetchData(skip: Int, limit: Int) async throws -> [Event] {
        var rangeMin: Date? = nil
        var rangeMax: Date? = nil
        var bookmarks: [String]? = nil
        if filterTypes.contains(.Day) || filterTypes.contains(.TimeRange) {
            rangeMin = selectedRangeMin
            rangeMax = selectedRangeMax
        }
        if filterTypes.contains(.Bookmarks) {
            bookmarks = eventBookmarks
        }
        
        return try await EventRepositoryImpl.getEvents(
            districtState: districtState,
            dateRangeMin: rangeMin,
            dateRangeMax: rangeMax,
            limit: limit,
            skip: skip,
            searchText: debounceSearchText,
            bookmarkedIds: bookmarks
        )
    }
    
    /**
     Because multithreading is made like garbage in iOS, this function diverges from the Android implementation.
     In Android, this function would inform whether a change was made or not and a call to [requestEvents] would be made.
     As chaining async calls does not work that easily in Swift, change detection is made with SwiftUI Publishers.
     */
    func changeDates(start: Date, end: Date)  {
        if (start != selectedRangeMin || end != selectedRangeMax) {
            selectedRangeMin = start
            selectedRangeMax = end
        }
    }
    
    func getDateOfTab(_ tab: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: tab, to: Date.now)!
    }
    
    func changeTab(_ tab: Int) {
        let date = getDateOfTab(tab)
        selectedRangeMin = date
        selectedRangeMax = date
        
        filterTypes.insert(.Day)
        filterTypes.remove(.TimeRange)
    }
}

enum FilterType {
    case Day, TimeRange, Bookmarks // TODO: Category
}
