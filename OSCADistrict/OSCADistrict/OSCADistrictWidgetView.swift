import SwiftUI
import SDWebImageSwiftUI
import Factory

struct OSCADistrictWidgetView: View {
    @InjectedObject(\.districtViewModel) var districtViewModel
    
    var body: some View {
        ZStack(alignment: .center) {
            LoadingWrapper(loadingStates: districtViewModel.loadingState) {
                ZStack(alignment: .center) {
                    if case .district(let district) = districtViewModel.districtState {
                        WebImage(url: URL(string: getHttps(district.image.url!)))
                            .resizable()
                            .renderingMode(.original)
                            .transition(.fade)
                            .scaledToFill()
                            .overlay {
                                Rectangle()
                                    .foregroundColor(.black)
                                    .opacity(0.3)
                            }
                    } else {
                        Image("dashboard_image", bundle: getBundle())
                            .resizable()
                            .renderingMode(.original)
                            .scaledToFill()
                            .overlay {
                                Rectangle()
                                    .foregroundColor(.black)
                                    .opacity(0.3)
                            }
                    }
                    Text(verbatim: getTitle()).foregroundColor(Color.white).font(DistrictDesign.Size.Font.HEADLINE)
                }.frame(height: 150).clipShape(DistrictDesign.ROUNDED_RECTANGLE)
            }.task {
                await districtViewModel.initFetch()
            }
        }.frame(maxWidth: .infinity).frame(height: 130).padding(.top, 10)
    }
    
    func getHttps(_ url: String) -> String {
        var https = url
        if (!url.starts(with: "https")) {
            https = url.replacingOccurrences(of: "http", with: "https")
        }
        return https
    }
    
    func getBundle() -> Bundle {
#if SWIFT_PACKAGE
        return Bundle.module
#else
        guard let bundle = Bundle(identifier: "de.nedeco-osca.District") else {
            fatalError("Module bundle not initialized!")
        }
        return bundle
#endif
    }
    
    func getTitle() -> String {
        if case .district(let district) = districtViewModel.districtState {
            return String(localized: "district \(district.name)", bundle: getBundle())
        } else {
            return String(localized: "city_name", bundle: getBundle())
        }
    }
    
    func getDistrict() -> String? {
        if case .district(let district) = districtViewModel.districtState {
            return district.name
        } else {
            return nil
        }
    }
}
