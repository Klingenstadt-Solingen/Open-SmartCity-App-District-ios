import SwiftUI
import SDWebImageSwiftUI
import ParseCore
import Foundation

import MapKit
import CoreLocation


struct VehicleListItem: View {
    var vehicle: Vehicle
    var defaultIconUrl: String
    
    var body: some View {
        GeneralNavigationLink(route: .mobilityVehicleDetailScreen(vehicle.id)) {
            MobilityListItem(
                defaultIconUrl: defaultIconUrl,
                mobilityObject: vehicle
            ) {
                if let batteryPercentage = vehicle.batteryPercentage {
                    
                    BatteryView(
                        batteryLevel: batteryPercentage
                    ).font(DistrictDesign.Size.Font.SMALLER_TEXT)
                }
            }
          
        }.buttonStyle(GeneralButtonStyle())
        .frame(maxWidth: .infinity, alignment: .top)
    }
}


#Preview {
    //VehicleListItem()
}
