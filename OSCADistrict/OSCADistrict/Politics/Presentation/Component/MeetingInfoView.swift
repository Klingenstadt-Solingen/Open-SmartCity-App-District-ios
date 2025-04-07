import SwiftUI

struct MeetingInfoView: View {
    var meeting: PoliticMeeting
    var body: some View {
        HStack(spacing: DistrictDesign.Spacing.DEFAULT) {
            Image("ic_clock", bundle: OSCADistrict.bundle)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: DistrictDesign.Size.Icon.BIG, maxHeight: DistrictDesign.Size.Icon.BIG)
                .foregroundColor(.primary)
            if let startDateTime = meeting.startDateTime, let endDateTime = meeting.endDateTime {
                VStack(alignment: .leading, spacing: DistrictDesign.Spacing.DEFAULT) {
                    Text("\(startDateTime.formatted(.dateTime.hourMinute())) -").font(DistrictDesign.Size.Font.DEFAULT)
                    Text(endDateTime, format: .dateTime.hourMinute()).font(DistrictDesign.Size.Font.DEFAULT)
                }
            }
        }.font(DistrictDesign.Size.Font.NORMAL_TEXT)
    }
}
