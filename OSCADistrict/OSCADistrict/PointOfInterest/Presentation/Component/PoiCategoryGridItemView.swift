import SwiftUI

struct PoiCategoryGridItemView: View {
    var categorie: PoiCategory;
    @Binding var selected : Bool
    
    var body: some View {
        Toggle(isOn: $selected) {
            PoiCategoryItemView(
                image: categorie.sourceId,
                name: categorie.mapTitle
            )
        }.toggleStyle(OSCAFadeButtonToggleStyle())
    }
}


