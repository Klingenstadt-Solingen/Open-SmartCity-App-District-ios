import SwiftUI
import SDWebImageSwiftUI
import ParseCore
import Foundation

import MapKit
import CoreLocation

struct TabBar: View {
    var mobilityTypes: [MobilityType] = []
    @Binding var selectedMobilityType: MobilityType?
    @State var selectIndex: Int = 0

    var body: some View {
        HStack(spacing: DistrictDesign.Spacing.DEFAULT) {
            ForEach(Array(mobilityTypes.enumerated()), id: \.element) { index, mobilityType in
                Button(action: {
                    selectIndex = index
                    selectedMobilityType = mobilityTypes[index]
                }) {
                    WebImage(url: URL(string: mobilityType.iconUrl))
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color.primary)
                        .scaledToFit()
                        .clipShape(DistrictDesign.ROUNDED_RECTANGLE)
                        .frame(
                            width: DistrictDesign.Size.Icon.BIGGER,
                            height: DistrictDesign.Size.Icon.BIGGER,
                            alignment: .center
                        ).padding(DistrictDesign.Padding.DEFAULT)
                }.frame(maxWidth: .infinity, alignment: .center)
                    .background((index == selectIndex ? Color.white : .clear).animation(.bouncy))
                    .clipShape(DistrictDesign.ROUNDED_RECTANGLE)
            }
        }
        .padding(DistrictDesign.Padding.SMALLEST)
        .background(Color.gray.opacity(0.1))
        .clipShape(DistrictDesign.ROUNDED_RECTANGLE)
    }
}


//#Preview {
   /* @State var selectIndex: Int = 0
    TabBar(iconUrlList: ["https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/android.svg","https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/android.svg","https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/android.svg"], selectIndex: $selectIndex)
    */
//}
