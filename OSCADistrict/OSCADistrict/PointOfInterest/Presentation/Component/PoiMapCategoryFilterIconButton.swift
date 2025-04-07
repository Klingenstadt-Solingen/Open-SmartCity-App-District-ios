import Foundation
import SwiftUI

struct PoiMapCategoryFilterIconButton : View {
    var onToggle : ((Bool) -> Void)?
    var onCheckedChange : ((PoiCategory, Bool) -> Void)?
    var categories : [PoiCategory] = []
    var selectedCategories : Set<String> = []
    @Binding var showCategories : Bool
    
    
    var body : some View {
        Button {
            onToggle?(!showCategories)
        } label: {
            Image("ic_filter", bundle: OSCADistrict.bundle)
                .resizable()
                .frame(alignment: .center)
                .padding(DistrictDesign.Padding.MEDIUM)
                .foregroundColor(.primary)
                .accessibilityLabel(Text("filter_button", bundle: OSCADistrict.bundle)).font(DistrictDesign.Size.Font.DEFAULT)
                .accessibilityElement(children: .combine)
        }.buttonStyle(OSCAImageButtonStyle())
            .frame(width: DistrictDesign.Size.Icon.HUGE, height: DistrictDesign.Size.Icon.HUGE, alignment: .bottomTrailing)
            .padding(DistrictDesign.Padding.BIGGER)
            .popover(isPresented: $showCategories) {
                if #available(iOS 16.0, *) {
                    PoiCategoryGridView(
                        onCheckedChange: onCheckedChange,
                        categories: categories,
                        selectedCategories: selectedCategories
                    )
                    .presentationDetents(
                        [.medium]
                    )
                    .frame(width: 400)
                    .presentationDragIndicator(.visible)
                }
            }
    }
    
    
}
