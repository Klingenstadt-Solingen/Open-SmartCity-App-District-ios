import Foundation
import ParseCore

class EventBoothDetailViewModel: Loadable {
    @Published var loadingState: LoadingState = .initializing
    @Published var eventTags: [EventTag] = []
    @Published var eventSponsors: [EventSponsor] = []
    
    func getEventBoothTags(objectId: String) async {
        await loadingStateScope {
            let newEventTags = try await EventRepositoryImpl.getEventTagsByEventBoothId(objectId)
            await MainActor.run {
                eventTags = newEventTags
            }
        }
    }
    
    func getEventBoothSponsors(objectId: String) async {
        await loadingStateScope {
            let newEventSponsors = try await EventRepositoryImpl.getEventBoothSponsorsByEventBoothId(objectId)
            await MainActor.run {
                eventSponsors = newEventSponsors
            }
        }
    }
}
