import SwiftUI
import Factory

struct ProjectTileView: View {
    @InjectedObject(\.districtViewModel) var districtViewModel
    @StateObject var viewModel = ProjectViewModel()
    
    var body: some View {
        DashboardDefaultTile(title: "project_title", image: "ic_cog", count: $viewModel.count
        ).task(id: districtViewModel.districtState) {
            await viewModel.getCount(districtState: districtViewModel.districtState)
        }
    }
}
