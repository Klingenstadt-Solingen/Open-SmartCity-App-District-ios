import SwiftUI
import SDWebImageSwiftUI
import ParseCore
import Foundation

import MapKit
import CoreLocation


struct StationListItem: View {
    var station: VehicleStation
    var defaultIconUrl: String

    var body: some View {
        GeneralNavigationLink(route: .mobilityStationDetailScreen(station.id)){
            VStack{
                MobilityListItem(
                    defaultIconUrl: defaultIconUrl,
                    mobilityObject: station
                ) {
                    Text(
                        "\(station.availableVehicleAmount) / \(station.parkingSpacesAmount)"
                    )
                }
                ForEach(Array(station.vehicles.enumerated()), id: \.offset){ index, vehicle in
                    HStack{
                        VStack{
                            WebImage(url: URL(string: vehicle.iconUrl ?? ""))
                                .resizable()
                                .scaledToFit()
                                .frame(minWidth: DistrictDesign.Size.Icon.SMALL, maxWidth: DistrictDesign.Size.Icon.SMALL,minHeight: DistrictDesign.Size.Icon.SMALL, maxHeight: DistrictDesign.Size.Icon.SMALL)
                                .padding(DistrictDesign.Padding.MEDIUM)
                                .overlay(
                                    DistrictDesign.ROUNDED_RECTANGLE
                                        .stroke(Color.primary, lineWidth: 2)
                                    )
                        }
                        VStack {
                            Text(station.information)
                                .font(DistrictDesign.Size.Font.SMALLER_TEXT)
                                .lineLimit(2)
                        }.frame(maxWidth: .infinity, alignment: .leading)
                        VStack{
                            Text("entfernung vom Startort")
                                .font(DistrictDesign.Size.Font.SMALLER_TEXT).bold()
                                .lineLimit(2)
                        }.frame(alignment: .leading)
                    }.frame(maxWidth: .infinity, alignment: .top).padding(DistrictDesign.Padding.MEDIUM)
                    Divider()
                }
            }
        }.buttonStyle(GeneralButtonStyle()).frame(maxWidth: .infinity, alignment: .center)
    }
}


#Preview {
    //StationListItem()
}
