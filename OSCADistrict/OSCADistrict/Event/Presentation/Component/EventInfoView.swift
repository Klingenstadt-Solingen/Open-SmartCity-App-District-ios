import SwiftUI

struct EventInfoView: View {
    var event: Event
    
    var body: some View {
        HStack(spacing: DistrictDesign.Spacing.DEFAULT) {
            switch (event.eventStatus) {
            case "canceled":
                EventStatusInfo(
                    statusKey: "event_canceled",
                    systemImageName: "calendar.badge.exclamationmark",
                    color: Color.red
                )
            default:
                EventDateTimeView(startDate: event.startDate, endDate: event.endDate)
                EventLocationView(eventLocation: EventDetails(event))
            }
        }.frame(maxWidth: .infinity, maxHeight: 30,alignment: .leading)
    }
}

#Preview {
    EventInfoView(event: Event())
}
