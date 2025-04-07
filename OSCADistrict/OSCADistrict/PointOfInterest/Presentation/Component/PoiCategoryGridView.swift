import SwiftUI

struct PoiCategoryGridView: View {
    var onCheckedChange : ((PoiCategory, Bool) -> Void)?
    var categories : [PoiCategory] = []
    var selectedCategories : Set<String> = []
    @EnvironmentObject var poiCategoryViewModel: PoiCategoryViewModel
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: 100))], spacing: DistrictDesign.Spacing.BIG) {
                ForEach(categories) {
                    cat in
                    
                    PoiCategoryGridItemView(
                        categorie: cat,
                        selected: Binding(
                            get: {
                                selectedCategories.contains(cat.sourceId)
                            },
                            set: {
                                val in
                                onCheckedChange?(cat, val)
                            }
                        )
                    )
                }.foregroundColor(Color.black)
            }
            .padding(DistrictDesign.Padding.BIGGER)
        }
    }
}


#Preview {
    PoiCategoryGridView()
        .environmentObject(PoiMapViewModel())
}
