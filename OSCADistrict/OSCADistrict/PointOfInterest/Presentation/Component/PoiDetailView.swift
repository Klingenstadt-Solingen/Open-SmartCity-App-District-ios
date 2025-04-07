import SwiftUI
import SDWebImageSwiftUI

struct PoiDetailView: View {
    var poiObjectId: String
    var poiCategory: PoiCategory?
    @EnvironmentObject var poiDetailViewModel: PoiDetailViewModel
    @EnvironmentObject var poiCategoryViewModel: PoiCategoryViewModel

    var body: some View {
        VStack(spacing: DistrictDesign.Spacing.BIG) {
            LoadingWrapper(loadingStates: poiDetailViewModel.loadingState) {
                
                if let poi = poiDetailViewModel.pointOfInterest {
                    
                    HStack(spacing: DistrictDesign.Spacing.DEFAULT) {
                        WebImage(url: poiCategoryViewModel.getIconImageUrl(poiCategory:poiCategory?.sourceId ?? ""))
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color.primary)
                            .frame(maxWidth: DistrictDesign.Size.Icon.BIGGER, maxHeight: DistrictDesign.Size.Icon.BIGGER)
                        Text(poi.name)
                            .font(DistrictDesign.Size.Font.HEADLINE)
                        Spacer()
                    }
                    
                    ScrollView {
                        var details = poi.getDetails()
                        
                        VStack(alignment: .leading, spacing: DistrictDesign.Spacing.BIG) {
                            ForEach(details, id: \.self) { detail in
                                PoiDetailListItemView(detail: detail)
                                
                                Divider()
                            }
                        }
                        
                    }
                }
            }
            Spacer()
        }.padding(DistrictDesign.Padding.BIGGER)
        .task {
            await poiDetailViewModel.requestPoiById(poiObjectId)
        }
    }
}
