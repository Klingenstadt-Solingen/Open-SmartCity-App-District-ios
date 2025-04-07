import SwiftUI
import SDWebImageSwiftUI
import ParseCore
import Foundation

import MapKit
import CoreLocation

struct MobilityDefaultSearchItem: View {
    var last: [String] = ["Haltestelle A Solingen", "Haltestelle B Solingen", "Haltestelle C Solingen", "Hauptstraße 10, 42651 Solingen"]
    var body: some View {
        LazyVStack(spacing:DistrictDesign.Padding.DEFAULT) {
            Text("Zuletzt")
            Divider()
            if(last.count > 0){
                ForEach(last, id: \.self) { text in
                    DefaultSearchRow(text: text)
                }
            }
        }.frame(maxWidth: .infinity, alignment: .topLeading)
        Spacer()
    }
}

private struct DefaultSearchRow: View {
    var text: String
    var iconUrl: String? = nil
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: DistrictDesign.Size.Icon.SMALL, height: DistrictDesign.Size.Icon.SMALL)
            }
            VStack {
                Text(text).font(DistrictDesign.Size.Font.NORMAL_TEXT).lineLimit(1)
            }.frame( maxWidth: .infinity, alignment: .leading )
            VStack {
                WebImage(url: URL(string: iconUrl ?? ""))
                .resizable()
                .scaledToFit()
                .clipShape(DistrictDesign.ROUNDED_RECTANGLE)
                .frame(width: DistrictDesign.Size.Icon.BIG, height: DistrictDesign.Size.Icon.BIG)
            }.frame(alignment: .trailing )
        }.frame( maxWidth: .infinity, alignment: .center )
        Divider()
    }
}
