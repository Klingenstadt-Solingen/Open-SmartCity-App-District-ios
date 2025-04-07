import SwiftUI
import Factory

struct EventWidgetView: View {
    @State private var selectedTab = 0
    @StateObject var viewModel = EventWidgetViewModel()
    @InjectedObject(\.bookmarkViewModel) var bookmarkViewModel
    @InjectedObject(\.districtViewModel) var districtViewModel
    private var timer = Timer.publish(every: 8, on: .main, in: .common).autoconnect()
    var onClick: ((String) -> Void)?
    
    init(onClick: ((String) -> Void)? = nil) {
        self.onClick = onClick
    }
    
    var body: some View {
        LoadingWrapper(loadingStates: viewModel.loadingState) {
            if viewModel.newestEvents.isEmpty {
                // TODO: Maybe Move Change Not Found Message in Pager
                HStack(alignment: .center, spacing: DistrictDesign.Spacing.DEFAULT) {
                    Spacer()
                    Text("no_major_events_found", bundle: OSCADistrict.bundle)
                        .font(DistrictDesign.Size.Font.SUB_SUB_TITLE)
                    Spacer()
                }.onAppear {
                    selectedTab = 0
                }
            } else {
                // TODO: Move Timer in Pager as auto mode
                // TODO: Disable Timer if page size is 1
                Pager(data: viewModel.newestEvents, selectedPage: $selectedTab) { event in
                    if let onClick = onClick {
                        Button(action: {
                            if let objectId = event.objectId {
                                onClick(objectId)
                            }
                        }) {
                            EventListItem(
                                event: event,
                                isBookmarked: bookmarkViewModel.isEventBookmarked(objectId: event.objectId)
                            ) {
                                bookmarkViewModel.toggleEventBookmark(objectId: event.objectId)
                            }
                        }
                    } else {
                        GeneralNavigationLink(route: .eventDetail(event.id)) {
                            EventListItem(
                                event: event,
                                isBookmarked: bookmarkViewModel.isEventBookmarked(objectId: event.objectId)
                            ) {
                                bookmarkViewModel.toggleEventBookmark(objectId: event.objectId)
                            }
                        }
                    }
                }.background(DistrictDesign.ROUNDED_RECTANGLE
                    .shadow().foregroundColor(Color.white))
                .foregroundColor(Color.black)
            }
        }.task(id: districtViewModel.districtState) {
            await viewModel.getEvents(districtState: districtViewModel.districtState)
        }.refreshable {
            await viewModel.getEvents(districtState: districtViewModel.districtState)
        }.onReceive(timer) { _ in
            let count = viewModel.newestEvents.count
            if count > 0 {
                selectedTab = (selectedTab + 1) % count
            }
        }
    }
}

#Preview {
    PressReleaseWidgetView()
}
