import SwiftUI
import Factory

struct PressReleaseTileView: View {
    @InjectedObject(\.districtViewModel) var districtViewModel
    @StateObject var viewModel = PressReleaseViewModel()
    
    var body: some View {
        DashboardDefaultTile(
            title: "press_release_title",
            image: "ic_megaphone_with_soundwave",
            count: $viewModel.count
        ).task(id: districtViewModel.districtState) {
            await viewModel.getCount(districtState: districtViewModel.districtState)
        }
    }
}

#Preview {
    PressReleaseTileView()
}
 

