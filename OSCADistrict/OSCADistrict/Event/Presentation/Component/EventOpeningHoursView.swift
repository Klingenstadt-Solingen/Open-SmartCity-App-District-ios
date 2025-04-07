import SwiftUI

struct EventOpeningHoursView: View {
    @EnvironmentObject var viewModel: EventDetailViewModel
    
    var body: some View {
        if (!viewModel.eventOpeningHours.isEmpty) {
            VStack(alignment: .leading, spacing: DistrictDesign.Spacing.DEFAULT) {
                Text("event_openinghours", bundle: OSCADistrict.bundle).font(DistrictDesign.Size.Font.SUB_SUB_TITLE).bold()
                ForEach(viewModel.eventOpeningHours, id: \.self) { eventOpeningHour in
                    HStack(alignment: .center, spacing: DistrictDesign.Spacing.BIG) {
                        Text("\(eventOpeningHour.startTime, format: .dateTime.weekdayDate()):")
                            .font(DistrictDesign.Size.Font.NORMAL_TEXT)
                        Text(
                            "event_from_to \(eventOpeningHour.startTime, format: .dateTime.hourMinute()) \(eventOpeningHour.endTime, format: .dateTime.hourMinute())",
                            bundle: OSCADistrict.bundle
                        ).font(DistrictDesign.Size.Font.NORMAL_TEXT)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                }
            }.frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}



