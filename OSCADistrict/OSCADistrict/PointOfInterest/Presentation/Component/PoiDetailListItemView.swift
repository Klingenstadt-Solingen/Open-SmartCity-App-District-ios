import SwiftUI
import SDWebImageSwiftUI
import OSCAEssentials

struct PoiDetailListItemView : View {
    var detail : OSCAPointOfInterestDetail

    var body : some View {
        HStack(spacing: 0) {
            WebImage(url: detail.getIconImageUrl())
                .resizable()
                .scaledToFill()
                .foregroundColor(Color.primary)
                .frame(maxWidth: DistrictDesign.Size.Icon.BIGGER, maxHeight: DistrictDesign.Size.Icon.BIGGER)
            VStack(alignment: .leading,spacing: 0) {
                Text(detail.title).font(DistrictDesign.Size.Font.SUB_SUB_TITLE.bold())
                if let subtitle = detail.subtitle {
                    Text(subtitle).font(DistrictDesign.Size.Font.NORMAL_TEXT)
                }
                if let value = detail.value {
                    PoiDetailValue(value: value, type: detail.type)
                }
            }
            Spacer()
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(detail.title): \(detail.subtitle ?? "") \(detail.value ?? "")")
    }
}
