import SwiftUI
import Factory

struct PoliticMeetingListScreen: View {
    var organizationId: String
    var title: String
    @State var showFuture = false
    
    @InjectedObject(\.politicMeetingListViewModel) var viewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: DistrictDesign.Spacing.DEFAULT) {
            Text(title)
                .font(DistrictDesign.Size.Font.HEADLINE)
                .padding(.horizontal, DistrictDesign.Padding.BIGGER)
            HStack(spacing: DistrictDesign.Spacing.DEFAULT) {
                Text("politic_meetings", bundle: OSCADistrict.bundle)
                    .font(DistrictDesign.Size.Font.SUB_SUB_TITLE.bold())
                Spacer()
                Toggle(isOn: $showFuture) {
                    Text("future_meetings", bundle: OSCADistrict.bundle)
                        .font(DistrictDesign.Size.Font.SUB_SUB_TITLE)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }.padding(.horizontal, DistrictDesign.Padding.BIGGER)
            
            PaginationLoadingWrapper(loadingState: viewModel.loadingState) {
                LazyVStack(spacing: DistrictDesign.Spacing.DEFAULT) {
                    ForEach(Array(viewModel.items.enumerated()), id: \.element.id) { index, meeting in
                        MeetingListItemView(meeting: meeting)
                            .task(id: index) {
                                if index == viewModel.items.endIndex - 1 && viewModel.items.endIndex % viewModel.pageSize == 0  {
                                    await viewModel.loadPage()
                                }
                            }
                    }
                }.frame(maxWidth: .infinity)
                    .padding(.horizontal, DistrictDesign.Padding.BIGGER)
                    .padding(.vertical, DistrictDesign.Padding.MEDIUM)
            }
            
        }
        .refreshableTask(id: "\(organizationId) \(showFuture)", pageable: viewModel) {
            viewModel.organizationId = organizationId
            viewModel.showFuture = showFuture
        }
    }
}

#Preview {
    PoliticMeetingListScreen(organizationId: "", title: "")
}

