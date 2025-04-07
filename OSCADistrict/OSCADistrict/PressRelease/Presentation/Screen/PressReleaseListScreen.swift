import SwiftUI
import Factory

struct PressReleaseListScreen: View {
    @InjectedObject(\.districtViewModel) var districtViewModel
    @StateObject var viewModel = PressReleaseListViewModel()
    @StateObject var pressReleaseViewModel = PressReleaseViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: DistrictDesign.Spacing.DEFAULT) {
            TitleView(title: "press_release_title").padding(.horizontal, DistrictDesign.Padding.BIGGER)
            PaginationLoadingWrapper(loadingState: viewModel.loadingState) {
                LazyVStack(spacing: DistrictDesign.Spacing.DEFAULT) {
                    ForEach(Array(viewModel.items.enumerated()), id: \.element.id) { index, pressRelease in
                        GeneralNavigationLink(route: .pressReleaseDetail(pressRelease.id)) {
                            PressReleaseListItemView(pressRelease: pressRelease)
                                .task(id: index) {
                                    if index == viewModel.items.endIndex - 1 && viewModel.items.endIndex % viewModel.pageSize == 0  {
                                        await viewModel.loadPage()
                                    }
                                }
                        }.buttonStyle(GeneralButtonStyle())
                    }
                }.padding(.horizontal, DistrictDesign.Padding.BIGGER)
                .padding(.vertical, DistrictDesign.Padding.MEDIUM)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .refreshableTask(id: "\(districtViewModel.districtState) \(viewModel.debounceSearchText)", pageable: viewModel) {
            pressReleaseViewModel.updateDate(districtState: districtViewModel.districtState)
            viewModel.districtState = districtViewModel.districtState
        }.searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
    }
}

#Preview {
    PressReleaseListScreen()
}
