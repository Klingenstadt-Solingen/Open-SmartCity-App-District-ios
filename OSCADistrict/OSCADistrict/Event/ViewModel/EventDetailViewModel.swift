import Foundation
import ParseCore
import UIKit
import EventKit

class EventDetailViewModel: Loadable {
    @Published var loadingState: LoadingState = .initializing
    @Published var event: Event = Event()
    let eventStore = EKEventStore()
    @Published var eventBooths: [EventBooth] = []
    @Published var eventSponsors: [EventSponsor] = []
    @Published var selectedEventBooth: EventBooth? = nil
    @Published var isEventAccessGranted = true
    
    @Published var eventOpeningHours: [EventOpeningHour] = []
    
    func getEvent(objectId: String) async {
        await loadingStateScope {
            let newEvent = try await EventRepositoryImpl.getEventById(objectId)
            let newEventBooths: [EventBooth] = try await EventRepositoryImpl.getEventBoothsByEventId(objectId)
            let newEventSponsors = try await EventRepositoryImpl.getEventSponsorsByEventId(objectId)
            let openingHours = try await EventRepositoryImpl.getEventOpeningHoursByEventId(objectId)

            await MainActor.run {
                eventBooths = newEventBooths
                eventSponsors = newEventSponsors
                eventOpeningHours = openingHours
                event = newEvent
            }
        }
    }
    
    func addToCalendar() async {
        isEventAccessGranted = EKEventStore.authorizationStatus(for: .event) != .denied
        var granted = if #available(iOS 17.0, *) {
            await try? eventStore.requestWriteOnlyAccessToEvents()
        } else {
            await try? eventStore.requestAccess(to: EKEntityType.event)
        }
        
        if (granted ?? false) {
            let calendarEvent = EKEvent(eventStore: eventStore)
            calendarEvent.startDate = event.startDate
            calendarEvent.endDate = event.endDate ?? event.startDate
            calendarEvent.title = event.name
            calendarEvent.calendar =  eventStore.defaultCalendarForNewEvents
            try? eventStore.save(calendarEvent, span: .thisEvent, commit: true)
        } else if (!isEventAccessGranted) {
            openSettings()
        }
    }
    
    func openSettings() {
        if let settinsUrl = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settinsUrl)
        }
    }
}
