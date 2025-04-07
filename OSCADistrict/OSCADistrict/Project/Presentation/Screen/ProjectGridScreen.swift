import SwiftUI
import Factory

struct ProjectGridScreen: View {
    @InjectedObject(\.districtViewModel) var districtViewModel
    @StateObject var viewModel = ProjectGridViewModel()
    @StateObject var projectViewModel = ProjectViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TitleView(title: "project_title")
                .padding(.horizontal, DistrictDesign.Padding.BIGGER)
            
            ScrollView(.horizontal) {
                ProjektStatusTabsView()
                    .environmentObject(viewModel)
                    .padding(.horizontal, DistrictDesign.Padding.BIGGER)
                    .padding(.vertical, DistrictDesign.Padding.SMALL)
            }.overlay(alignment: .leading) {
                LinearGradient(gradient: Gradient(colors: [.white,.white, .white.opacity(0)]), startPoint: .leading, endPoint: .trailing)
                    .frame(width: 18).allowsHitTesting(false)
            }.overlay(alignment: .trailing) {
                LinearGradient(gradient: Gradient(colors: [.white,.white, .white.opacity(0)]), startPoint: .trailing, endPoint: .leading)
                    .frame(width: 18).allowsHitTesting(false)
            }
            
            PaginationLoadingWrapper(loadingState: viewModel.loadingState) {
                LazyVGrid(columns: Array(repeating: DistrictDesign.GRID_CELLS_ADAPTIVE(), count: 2), spacing: DistrictDesign.Spacing.BIG) {
                    ForEach(Array(viewModel.items.enumerated()), id: \.element.id) { index, project in
                        GeneralNavigationLink(route: .projectDetail(project.objectId!)) {
                            ProjectGridItem(project: project).task(id: index) {
                                if index == viewModel.items.endIndex - 1 && viewModel.items.endIndex % viewModel.pageSize == 0  {
                                    await viewModel.loadPage()
                                }
                            }
                        }
                        .buttonStyle(GeneralButtonStyle(buttonColor: .primary))
                        .aspectRatio(1, contentMode: .fit)
                    }
                }
                .padding(.horizontal, DistrictDesign.Padding.BIGGER)
                .padding(.vertical, DistrictDesign.Padding.MEDIUM)
            }
            .refreshableTask(id: "\(districtViewModel.districtState) \(viewModel.debounceSearchText) \(viewModel.projectStatus)", pageable: viewModel){
                projectViewModel.updateDate(districtState: districtViewModel.districtState)
                viewModel.districtState = districtViewModel.districtState
            }.searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
