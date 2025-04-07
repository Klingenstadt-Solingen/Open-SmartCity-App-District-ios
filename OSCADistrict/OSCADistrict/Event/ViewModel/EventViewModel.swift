import Foundation

class EventViewModel: CountViewModel {
    init() {
        super.init(defaultsKey: "event")
    }
    
    override func fetchCount(lastWatched: Date, districtState: DistrictState) async -> Int {
        return await EventRepositoryImpl.getNewEventCount(districtState: districtState, watchedAt: lastWatched)
    }
}
