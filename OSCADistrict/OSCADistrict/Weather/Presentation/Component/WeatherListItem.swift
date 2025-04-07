import SwiftUI
import CoreLocation
import ParseCore

struct WeatherListItem: View {
    var weather: Weather
    var currentLocation: CLLocation?
    var selected: Bool
    
    var body: some View {
        HStack(spacing: DistrictDesign.Spacing.DEFAULT) {
            if let shortName = weather.shortName {
                Text(shortName)
                    .font(DistrictDesign.Size.Font.DEFAULT)
                    .lineLimit(1)
                    .padding(.leading, DistrictDesign.Padding.MEDIUM)
            } else {
                Text("weather_no_name", bundle: OSCADistrict.bundle)
                    .font(DistrictDesign.Size.Font.DEFAULT)
                    .lineLimit(1)
                    .padding(.leading, DistrictDesign.Padding.MEDIUM)
            }
            Spacer()
            Image("ic_location", bundle: OSCADistrict.bundle)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: DistrictDesign.Size.Icon.BIG)
                .foregroundColor(.primary)
            if let currentLocation = currentLocation, let distance = weather.geopoint?.distanceInKilometers(to: PFGeoPoint(location: currentLocation)) {
                if distance < 1000.0 {
                    if distance <= 1 {
                        Text("\(distance * 1000, specifier: "%.0f") m")
                            .font(DistrictDesign.Size.Font.NORMAL_TEXT)
                            .frame(width: 80, alignment: .trailing)
                    } else {
                        Text("\(distance, specifier: "%.1f") km")
                            .font(DistrictDesign.Size.Font.NORMAL_TEXT)
                            .frame(width: 80, alignment: .trailing)
                    }
                } else {
                    Text("+999.9 km")
                        .font(DistrictDesign.Size.Font.NORMAL_TEXT)
                        .frame(width: 80, alignment: .trailing)
                }
            } else {
                Text("----- km").font(DistrictDesign.Size.Font.NORMAL_TEXT)
            }
            ZStack{
                if selected {
                    Image(systemName: "checkmark.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: DistrictDesign.Size.Icon.BIG, maxHeight: DistrictDesign.Size.Icon.BIG)
                        .foregroundColor(.primary)
                }
            }
            .frame(width: DistrictDesign.Size.Icon.BIG)
            .padding(.leading, DistrictDesign.Padding.MEDIUM)
        }
        .font(DistrictDesign.Size.Font.NORMAL_TEXT)
        .padding(DistrictDesign.Padding.MEDIUM)
    }
}
