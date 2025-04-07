import SwiftUI
import Factory

struct EventTileView: View {
    @InjectedObject(\.districtViewModel) var districtViewModel
    @StateObject var viewModel = EventViewModel()
    
    var body: some View {
        DashboardDefaultTile(
            title: "event_title",
            image: "ic_confetti",
            count: $viewModel.count
        ).task(id: districtViewModel.districtState) {
            await viewModel.getCount(districtState: districtViewModel.districtState)
        }
    }
}

#Preview {
    EventTileView()
}
