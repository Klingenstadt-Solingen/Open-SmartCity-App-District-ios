import Foundation


class EventWidgetViewModel: Loadable {
    @Published var loadingState: LoadingState = .initializing
    var newestEvents: [Event] = []
    
    func getEvents(limit: Int = 5, districtState: DistrictState = .all) async {
        await loadingStateScope {
            let events = try await EventRepositoryImpl.getNextEvents(
                districtState: districtState,
                limit: limit
            )
            await MainActor.run {
                self.newestEvents = events
                loadingState = .loaded
            }
        }
    }
}
