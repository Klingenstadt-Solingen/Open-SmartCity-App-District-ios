import SwiftUI

struct ProjectDateView: View {
    let semanticsDateFrom = Text("from_date", bundle: OSCADistrict.bundle) + Text(": ")
    let semanticsDateUntil = Text("until_date", bundle: OSCADistrict.bundle) + Text(": ")
    
    var startDate: Date
    var endDate: Date?
    
    var body: some View {
        var start = Text(startDate, format: .dateTime.monthYear())
        
        HStack(spacing: DistrictDesign.Spacing.DEFAULT) {
            Image("ic_calendar", bundle: OSCADistrict.bundle)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: DistrictDesign.Size.Icon.BIG, maxHeight: DistrictDesign.Size.Icon.BIG)
                .foregroundColor(.primary)
            VStack(alignment: .leading, spacing: DistrictDesign.Spacing.SMALL) {
                start.accessibilityLabel(semanticsDateFrom + start).font(DistrictDesign.Size.Font.NORMAL_TEXT)
                if let endDate = endDate {
                    var end = Text(endDate, format: .dateTime.monthYear())
                    
                    end.accessibilityLabel(semanticsDateUntil + end).font(DistrictDesign.Size.Font.NORMAL_TEXT)
                }
            }
        }.accessibilityElement(children: .combine)
    }
}

#Preview {
    ProjectDateView(startDate: Date.now)
}
