import SwiftUI
import Factory

func navigationStyle(color: Color) {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithTransparentBackground()
    
    let image = UIImage(named: "ic_left", in: OSCADistrict.bundle, with: nil)?
        .withBaselineOffset(fromBottom: 1)
        .withTintColor(UIColor(Color.accentColor), renderingMode: .alwaysOriginal)
    
    let backItemAppearance = UIBarButtonItemAppearance()
    
    backItemAppearance.normal.titleTextAttributes = [.foregroundColor : UIColor.black, ]
    appearance.largeTitleTextAttributes = [
        .foregroundColor: UIColor(color),
        .font: UIFont.systemFont(ofSize: DistrictDesign.Size.Font.HEADLINE_SIZE, weight: .bold)
    ]
    appearance.backButtonAppearance = backItemAppearance
    appearance.setBackIndicatorImage(image, transitionMaskImage: image)
    appearance.titleTextAttributes = [
        .foregroundColor: UIColor(color)
    ]
    
    let bigAppearance = appearance.copy()
    bigAppearance.configureWithDefaultBackground()
    bigAppearance.backgroundColor = UIColor(Color.white)
    bigAppearance.titleTextAttributes = [
        .foregroundColor: UIColor.black
    ]
    UINavigationBar.appearance().standardAppearance = bigAppearance
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
    UINavigationBar.appearance().compactAppearance = bigAppearance
    UINavigationBar.appearance().compactScrollEdgeAppearance = appearance
}

struct BootstrapApp: View {
    var height: CGFloat = 0
    @InjectedObject(\.districtViewModel) var districtViewModel
    
    init(height: CGFloat) {
        self.height = height
        navigationStyle(color: Color.white)
    }
    
    var body: some View {
        LoadingWrapper(loadingStates: districtViewModel.loadingState) {
            Navigation(path: resolveDeeplinkPath())
        }.task {
            await districtViewModel.initFetch()
        }
        .environmentObject(districtViewModel)
        .environmentObject(BookmarkViewModel())
        .environmentObject(LocationViewModel())
        .progressViewStyle(OSCAProgressViewStyle())
        .padding(.bottom, -height)
    }
    
    func resolveDeeplinkPath() -> [Route] {
        if let deeplink = OSCADistrictSettings.shared.deeplink {
            let deeplinkQueryItems = URLComponents(
                string: deeplink.absoluteString
            )?.queryItems
            if deeplink.absoluteString.hasPrefix("solingen://events") {
                var route: [Route] = [.standaloneRoute, .event]
                if deeplink.absoluteString
                    .hasPrefix("solingen://events/detail"), let objectId = deeplinkQueryItems?.first(
                        where: { queryItem in
                            queryItem.name == "object"
                        }
                    )?.value {
                    route.append(.eventDetail(objectId))
                }
                return route
            }
        }
        return []
    }
}

#Preview {
    BootstrapApp(height: 0)
}
