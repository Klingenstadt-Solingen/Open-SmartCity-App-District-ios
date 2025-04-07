import SwiftUI
import SDWebImageSwiftUI
import OSCAEssentials

struct PoiMarkerContentView: View {
    var poi: OSCAPointOfInterest
    @Binding var selectedPoi: OSCAPointOfInterest?
    @EnvironmentObject var poiCategoryViewModel: PoiCategoryViewModel
    
    var body: some View {
        Button(action: {
            selectedPoi = poi
        }) {
            WebImage(
                url: poiCategoryViewModel.getImageUrl(poiCategory: poi.poiCategory)
            )
            .resizable()
            .scaledToFit()
        }
    }
}

#Preview {
    PoiMarkerContentView(poi: OSCAPointOfInterest(), selectedPoi: .constant(OSCAPointOfInterest()))
}
