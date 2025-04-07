import SwiftUI
import Factory

struct EventListScreen: View {
    @InjectedObject(\.districtViewModel) var districtViewModel
    @InjectedObject(\.bookmarkViewModel) var bookmarkViewModel
    @StateObject var eventListViewModel = EventListViewModel()
    @StateObject var eventViewModel = EventViewModel()
    @State private var scrollViewID = UUID()
    
    var body: some View {
        VStack(alignment: .leading,spacing: DistrictDesign.Spacing.DEFAULT) {
            TitleView(title: "event_title").padding(.horizontal, DistrictDesign.Padding.BIGGER)
            EventDayTabs().environmentObject(eventListViewModel).padding(.horizontal, DistrictDesign.Padding.BIGGER)
            PaginationLoadingWrapper(loadingState: eventListViewModel.loadingState) {
                LazyVStack(spacing: DistrictDesign.Spacing.DEFAULT) {
                    ForEach(Array(eventListViewModel.items.enumerated()), id: \.element.id) { index, event in
                        GeneralNavigationLink(route: .eventDetail(event.id)) {
                            EventListItem(
                                event: event,
                                isBookmarked: bookmarkViewModel.isEventBookmarked(objectId: event.objectId)
                            ) {
                                bookmarkViewModel.toggleEventBookmark(objectId: event.objectId)
                                eventListViewModel.eventBookmarks = bookmarkViewModel.eventBookmarks
                            }.task(id: index) {
                                if index == eventListViewModel.items.endIndex - 1 && eventListViewModel.items.endIndex % eventListViewModel.pageSize == 0  {
                                    await eventListViewModel.loadPage()
                                }
                            }
                        }.buttonStyle(GeneralButtonStyle())
                    }
                }
                .padding(.horizontal, DistrictDesign.Padding.BIGGER)
                .padding(.vertical, DistrictDesign.Padding.MEDIUM)
            }.refreshableTask(id: "\(eventListViewModel.selectedRangeMin) \(eventListViewModel.selectedRangeMax) \(districtViewModel.districtState) \(eventListViewModel.debounceSearchText) \(eventListViewModel.filterTypes)", pageable: eventListViewModel) {
                eventListViewModel.eventBookmarks = bookmarkViewModel.eventBookmarks
                eventViewModel.updateDate(districtState: districtViewModel.districtState)
                eventListViewModel.districtState = districtViewModel.districtState
            }
          
        }.searchable(
            text: $eventListViewModel.searchText,
            placement: .navigationBarDrawer(displayMode: .always)
        )
        .sheet(isPresented: $eventListViewModel.showFilterPicker) {
            if #available(iOS 16.0, *) {
                FilterPickerView().environmentObject(eventListViewModel)
                    .presentationDragIndicator(.visible)
                    .presentationDetents([.height(220)])
                    .padding(DistrictDesign.Padding.BIGGER)
            }
        }.navigationBarTitleDisplayMode(.inline)
    }
}
