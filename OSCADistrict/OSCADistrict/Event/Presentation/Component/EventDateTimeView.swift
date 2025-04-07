import SwiftUI

struct EventDateTimeView: View {
    var startDate: Date
    var endDate: Date?
    let semanticsFrom = Text("time_from", bundle: OSCADistrict.bundle) + Text(": ")
    let semanticsTo = Text("time_to", bundle: OSCADistrict.bundle) + Text(": ")
    
    var body: some View {
        let duration = startDate.dayDuration(endDate)
        HStack(spacing: DistrictDesign.Spacing.DEFAULT) {
            if duration < 2 {
                Image("ic_clock", bundle: OSCADistrict.bundle)
                    .resizable()
                    .scaledToFit()
                    .frame(
                        maxWidth: DistrictDesign.Size.Icon.BIG,
                        maxHeight: DistrictDesign.Size.Icon.BIG
                    )
                    .foregroundColor(.primary)
                VStack(alignment: .leading,spacing: DistrictDesign.Spacing.SMALL) {
                    if let endDate = endDate {
                        var from = Text("\(startDate.formatted(.dateTime.hourMinute())) -")
                        var to = Text(endDate, format: .dateTime.hourMinute())
                        
                        from
                            .font(DistrictDesign.Size.Font.NORMAL_TEXT)
                            .accessibilityLabel(semanticsFrom + from)
                        to
                            .font(DistrictDesign.Size.Font.NORMAL_TEXT)
                            .accessibilityLabel(semanticsTo + to)
                    } else {
                        var from = Text(startDate, format: .dateTime.hourMinute())
                        from
                            .font(DistrictDesign.Size.Font.NORMAL_TEXT)
                            .accessibilityLabel(semanticsFrom  + from)
                    }
                }.frame(alignment: .leading)
            } else {
                Image("ic_calendar", bundle: OSCADistrict.bundle)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: DistrictDesign.Size.Icon.BIG, maxHeight: DistrictDesign.Size.Icon.BIG)
                    .foregroundColor(.primary)
                Text("day \(duration, specifier: "%lld")", bundle: OSCADistrict.bundle)
                    .font(DistrictDesign.Size.Font.NORMAL_TEXT)
            }
        }.accessibilityElement(children: .combine)
    }
}

#Preview {
    EventDateTimeView(startDate: Date.now)
}
