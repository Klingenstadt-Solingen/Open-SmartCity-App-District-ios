import SwiftUI
import Factory

struct PressReleaseWidgetView: View {
    @State private var selectedTab = 0
    @StateObject var viewModel = PressReleaseWidgetViewModel()
    @InjectedObject(\.districtViewModel) var districtViewModel
    private var timer = Timer.publish(every: 8, on: .main, in: .common).autoconnect()

    var body: some View {
        LoadingWrapper(loadingStates: viewModel.loadingState) {
            if viewModel.newestPressReleases.isEmpty {
                // TODO: Maybe Move Change Not Found Message in Pager
                HStack(alignment: .center, spacing: DistrictDesign.Spacing.DEFAULT) {
                    Spacer()
                    Text("no_press_release_found", bundle: OSCADistrict.bundle)
                        .font(DistrictDesign.Size.Font.SUB_SUB_TITLE)
                    Spacer()
                }.onAppear {
                    selectedTab = 0
                }
            } else {
                // TODO: Move Timer in Pager as auto mode
                // TODO: Disable Timer if page size is 1
                Pager(data: viewModel.newestPressReleases, selectedPage: $selectedTab) { pressRelease in
                    PressReleaseWidgetItemView(pressRelease: pressRelease)
                }
            }
        }.task(id: districtViewModel.districtState) {
            await viewModel.getPressReleases(districtState: districtViewModel.districtState)
        }.refreshable {
            await viewModel.getPressReleases(districtState: districtViewModel.districtState)
        }.onReceive(timer) { _ in
            let count = viewModel.newestPressReleases.count
            if count > 0 {
                selectedTab = (selectedTab + 1) % count
            }
        }
    }
}

#Preview {
    PressReleaseWidgetView()
}
