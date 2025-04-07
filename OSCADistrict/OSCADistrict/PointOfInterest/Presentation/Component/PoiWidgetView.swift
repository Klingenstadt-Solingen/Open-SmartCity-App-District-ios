import SwiftUI

struct PoiWidgetView: View {
    @StateObject var poiCategoryViewModel = PoiCategoryViewModel()
    
    var body: some View {
        LoadingWrapper(loadingStates: poiCategoryViewModel.loadingState) {
            ScrollView(.horizontal) {
                HStack(alignment: .center, spacing: DistrictDesign.Spacing.MEDIUM) {
                    ForEach(0..<poiCategoryViewModel.categories.endIndex, id: \.self) { index in
                        GeneralNavigationLink(route: .poiMap(poiCategoryViewModel.categories[index].sourceId)) {
                            PoiCategoryItemView(
                                image: poiCategoryViewModel.categories[index].sourceId,
                                name: poiCategoryViewModel.categories[index].mapTitle
                            ).frame(width: 100)
                        }.foregroundColor(Color.black)
                    }
                }
            }.overlay(alignment: .leading) {
                LinearGradient(gradient: Gradient(colors: [.white, .white.opacity(0)]), startPoint: .leading, endPoint: .trailing)
                    .frame(width: DistrictDesign.Size.Icon.SMALL).allowsHitTesting(false)
            }.overlay(alignment: .trailing) {
                LinearGradient(gradient: Gradient(colors: [.white, .white.opacity(0)]), startPoint: .trailing, endPoint: .leading)
                    .frame(width: DistrictDesign.Size.Icon.SMALL).allowsHitTesting(false)
            }
        }.task {
            await poiCategoryViewModel.requestCategories()
        }
    }
}

#Preview {
    PoiWidgetView()
}
