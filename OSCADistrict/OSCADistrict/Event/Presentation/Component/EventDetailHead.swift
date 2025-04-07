import SwiftUI

struct EventDetailHead: View {
    var event: Event
    
    var body: some View {
        VStack(alignment: .leading, spacing: DistrictDesign.Spacing.DEFAULT) {
            Text(event.startDate, format: .dateTime.dateOnly())
                .font(DistrictDesign.Size.Font.NORMAL_TEXT)
            Text(event.name)
                .font(DistrictDesign.Size.Font.HEADLINE)
                .lineLimit(3)
            Text(event.category)
                .font(DistrictDesign.Size.Font.NORMAL_TEXT)
            HStack(spacing: DistrictDesign.Spacing.DEFAULT) {
                EventInfoView(event: event)
                Spacer()
            }
        }
    }
}
