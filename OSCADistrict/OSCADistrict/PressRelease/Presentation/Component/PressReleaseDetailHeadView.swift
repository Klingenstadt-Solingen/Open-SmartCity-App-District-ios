import SwiftUI

struct PressReleaseDetailHeadView: View {
    var pressRelease : PressRelease
    
    var body: some View {
        VStack(alignment: .leading, spacing: DistrictDesign.Spacing.DEFAULT) {
            Text(pressRelease.date, format: .dateTime.dateOnly())
                .font(DistrictDesign.Size.Font.NORMAL_TEXT)
            Text(pressRelease.title)
                .font(DistrictDesign.Size.Font.HEADLINE)
            HStack(spacing: DistrictDesign.Spacing.DEFAULT) {
                ReadingTimeView(readingTime: pressRelease.readingTime)
                Spacer()
                if #available(iOS 16.0, *) {
                    if let url = pressRelease.url {
                        ShareLink(item: url) {
                            Image("ic_share", bundle: OSCADistrict.bundle)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: DistrictDesign.Size.Icon.BIG, maxHeight: DistrictDesign.Size.Icon.BIG)
                                .foregroundColor(Color.primary)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
   /* var release = PressRelease()
    release.title = "Title"
    release.date = Date()
    release.summary = "Summary"
    release.readingTime = 5
    release.imageUrl =  "https://images.pexels.com/photos/1366919/pexels-photo-1366919.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
    release.content = "LOREMIPSUM"
    PressReleaseDetailHeadView(pressRelease: release)
    */
}
