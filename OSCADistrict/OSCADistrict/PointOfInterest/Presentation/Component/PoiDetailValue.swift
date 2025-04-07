import SwiftUI
import OSCAEssentials

struct PoiDetailValue: View {
    var value: String
    var type: OSCAPointOfInterestDetailType
    
    var body: some View {
        switch type {
        case .tel:
            link(prefix: "tel:")
        case .mail:
            link(prefix: "mailto:")
        case .url:
            link()
        case .html:
            HtmlText(html: value, fontSize: DistrictDesign.Size.Font.NORMAL_TEXT_SIZE)
        default:
            Text(value).font(DistrictDesign.Size.Font.NORMAL_TEXT)
        }
    }
    
    @ViewBuilder
    func link(prefix: String = "") -> some View {
        if let url = URL(string: "\(prefix)\(value)") {
            Link(destination: url) { // THIS FEATURE ONLY WORKS ON A REAL PHONE
                HStack(spacing: DistrictDesign.Spacing.DEFAULT) {
                    Image("ic_right", bundle: OSCADistrict.bundle)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: DistrictDesign.Size.Icon.SMALL)
                        .foregroundColor(.accentColor)
                    Text(value).font(DistrictDesign.Size.Font.NORMAL_TEXT)
                        .frame(alignment: .leading)
                        .lineLimit(1)
                }
            }
        } else {
            Text(value).font(DistrictDesign.Size.Font.NORMAL_TEXT)
        }
    }
}

#Preview {
    PoiDetailValue(value: "example@example.org", type: .mail)
}
