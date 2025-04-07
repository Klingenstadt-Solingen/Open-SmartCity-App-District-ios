import SwiftUI
import CoreLocation
import ParseCore

struct LocationDistanceView: View {
    var latitude: Double
    var longitude: Double
    @EnvironmentObject var locationViewModel: LocationViewModel
    @State var distanceString: LocalizedStringKey = ""
    
    var body: some View {
        Text(distanceString, bundle: OSCADistrict.bundle)
            .font(DistrictDesign.Size.Font.NORMAL_TEXT)
            .task {
                var cLLocation = CLLocation(
                    latitude: latitude,
                    longitude: longitude
                )
                
                if let distance = await locationViewModel.getDistanceToCoordinate(coordinate: cLLocation) {
                    distanceString = if (distance < 1000) {
                        "meter_distance \(distance, specifier: "%.1f")"
                    } else {
                        "kilometer_distance \((distance / 1000), specifier: "%.1f")"
                    }
                }
        }
    }
}
