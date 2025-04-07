import SwiftUI
import SDWebImageSwiftUI

struct PressReleaseListItemView: View {
    var pressRelease: PressRelease
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            PressReleaseListItemImageView(url: pressRelease.imageUrl)
            VStack(alignment: .leading, spacing: DistrictDesign.Spacing.DEFAULT) {
                Text(pressRelease.date, format: .dateTime.dateOnly())
                    .font(DistrictDesign.Size.Font.NORMAL_TEXT)
                
                if #available(iOS 16.0, *) {
                    Text(pressRelease.title)
                        .font(DistrictDesign.Size.Font.SUB_SUB_TITLE.bold())
                        .lineLimit(2, reservesSpace: true)
                } else {
                    Text(pressRelease.title)
                        .font(DistrictDesign.Size.Font.SUB_SUB_TITLE.bold())
                        .lineLimit(2)
                }
                ReadingTimeView(readingTime: pressRelease.readingTime)
            }.padding(DistrictDesign.Padding.MEDIUM)
        }.frame(height: 120)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    PressReleaseListItemView(pressRelease: PressRelease())
}
