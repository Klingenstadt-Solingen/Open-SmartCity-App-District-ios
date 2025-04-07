import SwiftUI
import SDWebImageSwiftUI
import MapKit
import OSCAEssentials
import Factory

struct PoiMapScreen: View {
    // initial category provided by navigation, if null, all possible categories are used
    var categoryId: String? = nil
    @State private var categoryPresented: Bool = false
    @StateObject private var poiCategoryViewModel = PoiCategoryViewModel()
    @StateObject private var viewModel = PoiMapViewModel()
    @InjectedObject(\.districtViewModel) var districtViewModel
    @State private var selectedPoi: OSCAPointOfInterest?

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.16553398473733, longitude: 7.065702202877448),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )

    var body: some View {
        LoadingWrapper(loadingStates: poiCategoryViewModel.loadingState) {
            ZStack {
                PoiMapView(
                    districtState: districtViewModel.districtState,
                    annotationItems: viewModel.pointOfInterests,
                    region: region
                ) { poi in
                    PoiMapMarkerView(
                        title: poi.name,
                        coordinate: CLLocationCoordinate2D(
                            latitude: poi.geopoint.latitude,
                            longitude: poi.geopoint.longitude
                        ),
                        identifier: poi.id
                    ) {
                        PoiMarkerContentView(poi: poi, selectedPoi: $selectedPoi)
                    }
                
                }.sheet(item: $selectedPoi) { poi in
                    if #available(iOS 16.0, *) {
                        PoiDetailView(
                            poiObjectId: poi.objectId!,
                            poiCategory: poiCategoryViewModel.getCategory(sourceId: poi.poiCategory)
                        ).presentationDetents(
                            [.medium, .large]
                        )
                        .presentationDragIndicator(.visible).environmentObject(PoiDetailViewModel())
                    }
                }

                VStack(alignment: .leading, spacing: DistrictDesign.Spacing.DEFAULT) {
                    TitleView(title: "point_of_interest_title")
                        .padding(EdgeInsets(top: 0, leading: DistrictDesign.Padding.MEDIUM, bottom: DistrictDesign.Padding.MEDIUM, trailing: DistrictDesign.Padding.BIG))
                        .background {
                            PoiTitleShape()
                                .foregroundColor(.white)
                        }.frame(alignment: .topTrailing)
                    Spacer()

                    HStack(spacing: DistrictDesign.Spacing.DEFAULT) {
                        Spacer()
                        PoiMapCategoryFilterIconButton(
                            onToggle: {
                                selected in
                                categoryPresented = selected
                            },
                            onCheckedChange: {
                                cat, selected in

                                poiCategoryViewModel.select(categoryId: cat.sourceId, selected: selected)
                            },
                            categories: poiCategoryViewModel.categories,
                            selectedCategories: poiCategoryViewModel.selectedCategories,
                            showCategories: $categoryPresented
                        )
                    }
                }.task(id: "\(poiCategoryViewModel.selectedCategories)\(districtViewModel.districtState.hashValue)", nanoseconds: 500_000_000) {
                    await viewModel.requestPois(poiCategoryViewModel.selectedCategories, districtState: districtViewModel.districtState)
                }
            }
        }.task {
            // load points of interest based on a category provided with the navigation or all possible
            await poiCategoryViewModel.initCategories(categoryId: categoryId)
        }.navigationBarTitleDisplayMode(.inline)
        .environmentObject(poiCategoryViewModel)
        .environmentObject(viewModel)
    }
}


#Preview {
    PoiMapScreen()
}
