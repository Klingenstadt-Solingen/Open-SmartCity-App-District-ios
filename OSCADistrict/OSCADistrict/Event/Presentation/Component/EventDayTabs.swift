import SwiftUI

struct EventDayTabs: View {
    @EnvironmentObject var viewModel: EventListViewModel
    let titles: [LocalizedStringKey] = ["today","tomorrow","in_two_days"]
    
    var body: some View {
        HStack(spacing: DistrictDesign.Spacing.DEFAULT) {
            ForEach(0..<titles.endIndex, id: \.self) { index in
                var date = viewModel.getDateOfTab(index)
                var isSelected = date.isSameDay([viewModel.selectedRangeMin, viewModel.selectedRangeMax]) && viewModel.filterTypes.contains(
                    .Day
                )
                
                SelectableTextButton(
                    action: { viewModel.changeTab(index)},
                    label: titles[index],
                    selected: isSelected
                )
            }
            Spacer()
            SelectableButton(
                action: { viewModel.showFilterPicker.toggle() },
                selected: isSelected(),
                disableable: false
            ) {
                Image("ic_filter", bundle: OSCADistrict.bundle)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: DistrictDesign.Size.Icon.BIG, maxHeight: DistrictDesign.Size.Icon.BIG)
                    .foregroundColor(.primary)
                    .padding(DistrictDesign.Padding.MEDIUM)
            }.accessibilityLabel(Text("date_selection_button", bundle: OSCADistrict.bundle))
                .font(DistrictDesign.Size.Font.DEFAULT)
        }
    }
    
    func checkIfNoTabIsSelected() -> Bool {
        for index in 0...2 {
            let date = viewModel.getDateOfTab(index)
            if (date.isSameDay([viewModel.selectedRangeMin, viewModel.selectedRangeMax])) {
                return false
            }
        }
        return true
    }
    
    func isSelected() -> Bool {
        if !viewModel.filterTypes.contains(.Day) {
            return true
        } else {
            if checkIfNoTabIsSelected() {
                return true
            } else {
                return viewModel.filterTypes.contains(.Bookmarks)
            }
        }
    }
}
