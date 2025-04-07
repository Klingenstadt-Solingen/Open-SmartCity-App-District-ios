import Foundation

class ProjectViewModel: CountViewModel {
    init() {
        super.init(defaultsKey: "project")
    }
    
    override func fetchCount(lastWatched: Date, districtState: DistrictState) async -> Int {
        return await ProjectRepositoryImpl.getNewProjectCount(districtState: districtState, watchedAt: lastWatched)
    }
}
