import SwiftUI
import Factory

struct PoliticDistrictListScreen: View {
    @InjectedObject(\.politicDistrictListViewModel) var viewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: DistrictDesign.Spacing.DEFAULT) {
            TitleView(title: "politics_title")
                .padding(.horizontal, DistrictDesign.Padding.BIGGER)
            PaginationLoadingWrapper(loadingState: viewModel.loadingState) {
                LazyVStack(spacing: DistrictDesign.Spacing.DEFAULT) {
                    ForEach(Array(viewModel.items.enumerated()), id: \.element.id) { index, district in
                        GeneralNavigationLink(route: Route.politicDistrictDetail(district)) {
                            Text(district.name)
                                .font(DistrictDesign.Size.Font.SUB_SUB_TITLE)
                                .padding(DistrictDesign.Padding.HUGE)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }.buttonStyle(GeneralButtonStyle()).task(id: index) {
                            if index == viewModel.items.endIndex - 1 && viewModel.items.endIndex % viewModel.pageSize == 0  {
                                await viewModel.loadPage()
                            }
                        }
                    }
                }.frame(maxWidth: .infinity)
                    .padding(.horizontal, DistrictDesign.Padding.BIGGER)
                    .padding(.vertical, DistrictDesign.Padding.MEDIUM)
            }
        }.navigationBarTitleDisplayMode(.inline)
            .refreshableTask(id: "", pageable: viewModel)
    }
}

#Preview {
    PoliticDistrictListScreen()
}
