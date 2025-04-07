import SwiftUI
import SDWebImageSwiftUI
import ParseCore

struct EventSponsorPagerView: View {
    var sponsors: [EventSponsor]
    @State var selectedTab = 0

    var body: some View {
        let categoryName = Text("sponsors", bundle: OSCADistrict.bundle)
        
        VStack(alignment: .leading, spacing: DistrictDesign.Spacing.BIG) {
            categoryName
                .font(DistrictDesign.Size.Font.SUB_TITLE.bold())
                .padding(.horizontal, DistrictDesign.Padding.BIGGER)
            Pager(data: sponsors, selectedPage: $selectedTab) { sponsor in
                VStack(alignment: .leading, spacing: DistrictDesign.Spacing.DEFAULT) {
                    ZStack(alignment: .leading) {
                        if let url = sponsor.icon.url {
                            ZStack(alignment: .topTrailing) {
                                WebImage(url: URL(string: url))
                                    .resizable()
                                    .indicator { _, _ in
                                        ProgressView()
                                    }
                                    .transition(.fade)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxHeight: 160)
                                    .padding(DistrictDesign.Padding.SMALL)
                            }
                        }
                    }
                    .background(.white)
                    .clipShape(DistrictDesign.ROUNDED_RECTANGLE)
                    .frame(maxWidth: .infinity, alignment: .center)
                    HStack(alignment: .bottom, spacing: DistrictDesign.Spacing.DEFAULT) {
                        Text(sponsor.name)
                            .font(DistrictDesign.Size.Font.NORMAL_TEXT)
                            .lineLimit(2)
                        Spacer()
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, DistrictDesign.Padding.BIGGER)
                .accessibilityLabel(categoryName).font(DistrictDesign.Size.Font.DEFAULT)
                .accessibilityElement(children: .combine)
            }
        }
        .frame(height: 270)
    }
}
