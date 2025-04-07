import SwiftUI
import SDWebImageSwiftUI
import ParseCore

struct ProjectPartnerPagerView: View {
    @State var selectedTab = 0
    var partnerCategory: ProjectPartnerCategory
    var partners: [ProjectPartner]
    
    var body: some View {
        let semanticsOpenPage = Text("open_homepage", bundle: OSCADistrict.bundle)
        let categoryName = Text(partnerCategory.localizedStringKey(), bundle: OSCADistrict.bundle)
        
        VStack(alignment: .leading, spacing: DistrictDesign.Spacing.BIG) {
            categoryName
                .font(DistrictDesign.Size.Font.SUB_TITLE.bold())
                .padding(.horizontal, DistrictDesign.Padding.BIGGER)
            Pager(data: partners, selectedPage: $selectedTab) { partner in
                VStack(alignment: .leading, spacing: DistrictDesign.Spacing.DEFAULT) {
                    ZStack(alignment: .leading) {
                        if let url = URL(string: partner.url) {
                            Link(destination: url) {
                                ZStack(alignment: .topTrailing) {
                                    WebImage(url: URL(string: partner.image))
                                        .resizable()
                                        .indicator { _, _ in
                                            ProgressView()
                                        }
                                        .transition(.fade)
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxHeight: 160)
                                        .padding(DistrictDesign.Padding.SMALL)
                                    Image(systemName: "link.circle.fill") //TODO: Replace Image
                                        .resizable()
                                        .frame(width: DistrictDesign.Size.Icon.MEDIUM, height: DistrictDesign.Size.Icon.MEDIUM)
                                        .foregroundColor(.accentColor)
                                        .padding(DistrictDesign.Padding.SMALL)
                                }
                            }
                        } else {
                            WebImage(url: URL(string: partner.image))
                                .resizable()
                                .indicator { _, _ in
                                    ProgressView()
                                }
                                .transition(.fade)
                                .aspectRatio(contentMode: .fit)
                                .frame(maxHeight: 170)
                                .padding(DistrictDesign.Padding.SMALL)
                        }
                    }
                    .background(.white)
                    .clipShape(DistrictDesign.ROUNDED_RECTANGLE)
                    .frame(maxWidth: .infinity, alignment: .center)
                    HStack(alignment: .bottom, spacing: DistrictDesign.Spacing.DEFAULT) {
                        Text(partner.name)
                            .font(DistrictDesign.Size.Font.NORMAL_TEXT)
                            .lineLimit(2)
                        Spacer()
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, DistrictDesign.Padding.BIGGER)
                .accessibilityLabel(categoryName + Text(": ") + semanticsOpenPage + Text(" ") + Text(partner.name)).font(DistrictDesign.Size.Font.DEFAULT)
                .accessibilityElement(children: .combine)
            }
        }
        .frame(height: 270)
    }
}
