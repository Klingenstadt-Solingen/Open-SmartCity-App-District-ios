import SwiftUI
import SDWebImageSwiftUI
import ParseCore
import Foundation

import MapKit
import CoreLocation

struct MobilityListItem<Content> : View where Content : View {
    var defaultIconUrl: String
    var mobilityObject: any MobilityObject
    @ViewBuilder var content: () -> Content
    
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    var body: some View {
        HStack {
            VStack {
                WebImage(
                    url: URL(string: mobilityObject.iconUrl ?? defaultIconUrl)
                )
                .resizable()
                .scaledToFit()
                .frame(minWidth: DistrictDesign.Size.Icon.BIGGER, maxWidth: DistrictDesign.Size.Icon.BIGGER, minHeight: DistrictDesign.Size.Icon.BIGGER, maxHeight: DistrictDesign.Size.Icon.BIGGER)
                .padding(DistrictDesign.Padding.MEDIUM)
            }.frame(alignment: .center)
            
            VStack(
                alignment: .leading,
                spacing: DistrictDesign.Padding.SMALL
            ) {
                Text(mobilityObject.name)
                    .font(DistrictDesign.Size.Font.NORMAL_TEXT).bold()
                    .lineLimit(2)
                Text("address \(mobilityObject.address ?? "-")", bundle: OSCADistrict.bundle)
                    .font(DistrictDesign.Size.Font.SMALLER_TEXT)
                    .lineLimit(2)
                content()
            }.frame(maxWidth: .infinity, alignment: .topLeading)
            
            LocationDistanceView(
                latitude: mobilityObject.geopoint.x,
                longitude: mobilityObject.geopoint.y
            ).font(DistrictDesign.Size.Font.SMALLER_TEXT.bold())
            .lineLimit(2)
        }.frame(maxWidth: .infinity, alignment: .center)
        .padding(DistrictDesign.Padding.MEDIUM)
    }
}


#Preview {
    //VehicleListItem()
}
