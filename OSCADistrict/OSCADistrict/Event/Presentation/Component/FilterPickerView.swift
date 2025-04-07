import SwiftUI

struct FilterPickerView: View {
    @EnvironmentObject var eventListViewModel: EventListViewModel
    @State var isOnlyBookmarks: Bool = false
    @State var startDate: Date = Date.now
    @State var endDate: Date = Date.now
    
    var body: some View {
        VStack(spacing: DistrictDesign.Spacing.DEFAULT) {
            HStack(spacing: DistrictDesign.Spacing.DEFAULT) {
                Button(action: {
                    eventListViewModel.filterTypes.insert(.Day)
                    eventListViewModel.filterTypes.remove(.TimeRange)
                }) {
                    Text("date_day", bundle: OSCADistrict.bundle)
                        .font(DistrictDesign.Size.Font.SUB_SUB_TITLE(!eventListViewModel.filterTypes.contains(.Day)))
                        .padding(DistrictDesign.Padding.MEDIUM)
                }.buttonStyle(
                    OSCASelectionButtonStyle(
                        selected: eventListViewModel.filterTypes.contains(.Day)
                    )
                )
                .disabled(eventListViewModel.filterTypes.contains(.Day))
                .accessibilityAddTraits(eventListViewModel.filterTypes.contains(.Day) ? .isSelected : [])
                Button(action: {
                    eventListViewModel.filterTypes.insert(.TimeRange)
                    eventListViewModel.filterTypes.remove(.Day)
                }) {
                    Text("date_range", bundle: OSCADistrict.bundle)
                        .font(DistrictDesign.Size.Font.SUB_SUB_TITLE(!eventListViewModel.filterTypes.contains(.TimeRange)))
                        .padding(DistrictDesign.Padding.MEDIUM)
                }.buttonStyle(OSCASelectionButtonStyle(selected: eventListViewModel.filterTypes.contains(.TimeRange)))
                    .disabled(eventListViewModel.filterTypes.contains(.TimeRange))
                    .accessibilityAddTraits(eventListViewModel.filterTypes.contains(.TimeRange) ? .isSelected : [])
                Button(action: {
                    eventListViewModel.filterTypes.remove(.Day)
                    eventListViewModel.filterTypes.remove(.TimeRange)
                }) {
                    Text("all_dates", bundle: OSCADistrict.bundle)
                        .font(DistrictDesign.Size.Font.SUB_SUB_TITLE(eventListViewModel.filterTypes.contains(.Day) || eventListViewModel.filterTypes.contains(.TimeRange)))
                        .padding(DistrictDesign.Padding.MEDIUM)
                }.buttonStyle(OSCASelectionButtonStyle(selected: !eventListViewModel.filterTypes.contains(.Day) && !eventListViewModel.filterTypes.contains(.TimeRange)))
                    .disabled(!eventListViewModel.filterTypes.contains(.Day) && !eventListViewModel.filterTypes.contains(.TimeRange))
                    .accessibilityAddTraits(!eventListViewModel.filterTypes.contains(.Day) && !eventListViewModel.filterTypes.contains(.TimeRange) ? .isSelected : [])
                Spacer()
                Button(action: resetFilters) {
                    Image(systemName: "x.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: DistrictDesign.Size.Icon.BIG, maxHeight: DistrictDesign.Size.Icon.BIG)
                        .foregroundColor(.red)
                        .padding(DistrictDesign.Padding.MEDIUM)
                }.buttonStyle(GeneralButtonStyle())
                    .accessibilityLabel(Text("accept_selection_button", bundle: OSCADistrict.bundle))
                    .accessibilityRemoveTraits(.isSelected)
            }.frame(maxWidth: .infinity)
            
            if eventListViewModel.filterTypes.contains(.Day) {
                Text("choose_date", bundle: OSCADistrict.bundle)
                    .font(DistrictDesign.Size.Font.SUB_SUB_TITLE.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                DatePicker(selection: $startDate, displayedComponents: .date) {
                    Text("date", bundle: OSCADistrict.bundle).accessibilityHidden(true)
                }
                .accessibilityElement(children: .contain)
                .accessibilityLabel(Text("date", bundle: OSCADistrict.bundle))
            } else if eventListViewModel.filterTypes.contains(.TimeRange) {
                Text("choose_time_period", bundle: OSCADistrict.bundle).font(DistrictDesign.Size.Font.SUB_SUB_TITLE.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    DatePicker(selection: $startDate, displayedComponents: .date) {
                        Text("from_date", bundle: OSCADistrict.bundle).accessibilityHidden(true)
                    }  .accessibilityElement(children: .contain)
                        .accessibilityLabel(Text("from_date", bundle: OSCADistrict.bundle))
                    DatePicker(selection: $endDate, displayedComponents: .date) {
                        Text("until_date", bundle: OSCADistrict.bundle).accessibilityHidden(true)
                    }
                    .accessibilityElement(children: .contain)
                    .accessibilityLabel(Text("until_date", bundle: OSCADistrict.bundle))
                }
            } else {
                Text("no_time_filter", bundle: OSCADistrict.bundle).font(DistrictDesign.Size.Font.SUB_SUB_TITLE)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            Toggle(isOn: $isOnlyBookmarks) {
                Text("show_only_bookmarks_toggle", bundle: OSCADistrict.bundle).font(DistrictDesign.Size.Font.SUB_SUB_TITLE)
                    .frame(maxWidth: .infinity, alignment: .leading).tint(.accentColor)
            }.onChange(of: isOnlyBookmarks) { bookmarked in
                if (bookmarked) {
                    eventListViewModel.filterTypes.insert(.Bookmarks)
                } else {
                    eventListViewModel.filterTypes.remove(.Bookmarks)
                }
            }
        }.frame(maxHeight: .infinity, alignment: .top)
            .task {
                self.isOnlyBookmarks = eventListViewModel
                    .filterTypes.contains(.Bookmarks)
                self.startDate = eventListViewModel.selectedRangeMin
                self.endDate = eventListViewModel.selectedRangeMax
            }
            .onChange(of: startDate) { min in
                if endDate < min {
                    endDate = min
                }
                eventListViewModel.selectedRangeMin = startDate
            }.onChange(of: endDate, perform: { max in
                if (startDate > max) {
                    startDate = max
                }
                eventListViewModel.selectedRangeMax = endDate
            }).accessibilityElement(children: .contain)
            .accessibilityLabel(Text("date_selection_area", bundle: OSCADistrict.bundle))
    }
    
    private func resetFilters() {
        eventListViewModel.filterTypes.removeAll()
        eventListViewModel.changeTab(0)
        
    }
}
