import SwiftUI
import SDWebImageSwiftUI

@available(iOS 16.0, macOS 13.0, watchOS 9.0, *)
@available(tvOS, unavailable)
struct ShareButton: View {
    var url : String
    
    var body: some View {
        ShareLink(item: url) {
            Image("ic_share", bundle: OSCADistrict.bundle)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: DistrictDesign.Size.Icon.BIG, maxHeight: DistrictDesign.Size.Icon.BIG)
                .foregroundColor(Color.primary)
        }.accessibilityLabel(Text("share_button", bundle: OSCADistrict.bundle) + Text(" URL")).font(DistrictDesign.Size.Font.DEFAULT)
    }
}
