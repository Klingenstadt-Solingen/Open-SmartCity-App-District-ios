import Foundation

class PressReleaseViewModel: CountViewModel {
    init() {
        super.init(defaultsKey: "pressRelease")
    }
    
    override func fetchCount(lastWatched: Date, districtState: DistrictState) async -> Int {
        return await PressReleaseRepositoryImpl.getNewPressReleaseCount(districtState: districtState, watchedAt: lastWatched)
    }
}
