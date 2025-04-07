import SwiftUI
import SDWebImageSwiftUI
import Factory

struct DashboardImage: View {
    @InjectedObject(\.districtViewModel) var districtViewModel
    
    // TODO: ADD HTTPS TO URL UNTIL ISSUE IS RESOLVED WITH PARSE SERVER
    func getHttps(_ url: String) -> String {
        var https = url
        if (!url.starts(with: "https")) {
            https = url.replacingOccurrences(of: "http", with: "https")
        }
        return https
    }
    
    var body: some View {
        VStack(spacing: DistrictDesign.Spacing.DEFAULT) {
            if case .district(let district) = districtViewModel.districtState {
                GeometryReader { geo in
                    WebImage(url: URL(string: getHttps(district.image.url!)))
                        .resizable()
                        .renderingMode(.original)
                        .transition(.fade)
                        .frame(minWidth: geo.size.width)
                        .scaledToFit()
                }
            } else {
                Image("dashboard_image", bundle: OSCADistrict.bundle)
                    .resizable()
                    .scaledToFit()
            }
            Spacer()
        }
        .overlay {
            Rectangle()
                .foregroundColor(.black)
                .opacity(0.3)
        }
        .animation(.linear, value: districtViewModel.districtState)
        .frame(maxWidth: .infinity)
        .ignoresSafeArea(.all)
    }
}

#Preview {
    DashboardImage()
}
