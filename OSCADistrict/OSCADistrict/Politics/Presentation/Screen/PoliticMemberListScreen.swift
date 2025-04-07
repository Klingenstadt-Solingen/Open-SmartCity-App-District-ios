import SwiftUI
import Factory

struct PoliticMemberListScreen: View {
    var organizationId: String
    var title: String
    
    @InjectedObject(\.politicMemberListViewModel) var viewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: DistrictDesign.Spacing.DEFAULT) {
            Text(title)
                .font(DistrictDesign.Size.Font.HEADLINE)
                .padding(.horizontal, DistrictDesign.Padding.BIGGER)
            Text("politic_members", bundle: OSCADistrict.bundle)
                .font(DistrictDesign.Size.Font.SUB_SUB_TITLE.bold())
                .padding(.horizontal, DistrictDesign.Padding.BIGGER)
            
            PaginationLoadingWrapper(loadingState: viewModel.loadingState) {
                LazyVStack(spacing: DistrictDesign.Spacing.DEFAULT) {
                    ForEach(Array(viewModel.items.enumerated()), id: \.element.id) { index, membership in
                        GeneralNavigationLink(route: Route.politicMemberDetail(membership)) {
                            MemberListItemView(membership: membership)
                                .task(id: index) {
                                    if index == viewModel.items.endIndex - 1 && viewModel.items.endIndex % viewModel.pageSize == 0  {
                                        await viewModel.loadPage()
                                    }
                                }
                        }
                        .buttonStyle(GeneralButtonStyle())
                    }
                }.frame(maxWidth: .infinity)
                .padding(.horizontal, DistrictDesign.Padding.BIGGER)
                .padding(.vertical, DistrictDesign.Padding.MEDIUM)
            }
        }
        .refreshableTask(id: organizationId, pageable: viewModel) {
            viewModel.organizationId = organizationId
        }
    }
}
