import SwiftUI
import CoreLocation
import ParseCore

struct LocationNavigationView: View {
    var locationDescription: String
    var latitude: Double
    var longitude: Double
    @EnvironmentObject var locationViewModel: LocationViewModel
    @State var isRouteDialogPresented = false

    var body: some View {
        VStack(alignment: .leading, spacing: DistrictDesign.Spacing.DEFAULT) {
            Text("location_where", bundle: OSCADistrict.bundle)
                .font(DistrictDesign.Size.Font.SUB_SUB_TITLE)
                .bold()
            HStack(alignment: .top, spacing: DistrictDesign.Spacing.SMALL) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(locationDescription)
                        .font(DistrictDesign.Size.Font.BIG_TEXT)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    LocationDistanceView(
                        latitude: latitude,
                        longitude: longitude
                    ).font(DistrictDesign.Size.Font.NORMAL_TEXT)
                }.frame(maxWidth: .infinity, alignment: .leading)
                Button(action: {
                    isRouteDialogPresented = true
                }) {
                    Image("ic_navigation", bundle: OSCADistrict.bundle)
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: DistrictDesign.Size.Icon.BIG,
                            height: DistrictDesign.Size.Icon.BIG
                        )
                        .padding(DistrictDesign.Padding.MEDIUM)
                        .foregroundColor(Color.primary)
                }.buttonStyle(OSCASelectionButtonStyle(selected: true))
            }
        }.confirmationDialog("select_map_app", isPresented: $isRouteDialogPresented) {
            let coordinate2D = CLLocationCoordinate2D(
                latitude: latitude,
                longitude: longitude
            )
            Button(action: {locationViewModel.openRouteTo(coordinate: coordinate2D, mapType: .AppleMaps)}) {
                Text("apple_maps", bundle: OSCADistrict.bundle)
            }
            Button(action: {locationViewModel.openRouteTo(coordinate: coordinate2D, mapType: .GoogleMaps)}) {
                Text("google_maps", bundle: OSCADistrict.bundle)
            }
        }
    }
}
