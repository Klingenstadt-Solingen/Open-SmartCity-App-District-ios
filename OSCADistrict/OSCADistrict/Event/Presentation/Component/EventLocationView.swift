import SwiftUI

struct EventLocationView: View {
    var eventLocation: EventDetails
    
    var body: some View {
        HStack(spacing: DistrictDesign.Spacing.DEFAULT) {
            Image("ic_location", bundle: OSCADistrict.bundle)
                .resizable()
                .scaledToFit()
                .accessibilityLabel(Text("location", bundle: OSCADistrict.bundle))
                .frame(maxWidth: DistrictDesign.Size.Icon.BIG, maxHeight: DistrictDesign.Size.Icon.BIG)
                .foregroundColor(.primary)
            VStack(alignment: .leading,spacing: DistrictDesign.Spacing.SMALL) {
                if (!eventLocation.streetAdress.isEmpty) {
                    Text(eventLocation.streetAdress)
                        .font(DistrictDesign.Size.Font.NORMAL_TEXT)
                        .lineLimit(1)
                }
                if (!eventLocation.addressLocality.isEmpty || !eventLocation.postalCode.isEmpty) {
                    Text("\(eventLocation.addressLocality) \(eventLocation.postalCode)")
                        .font(DistrictDesign.Size.Font.NORMAL_TEXT)
                        .lineLimit(1)
                }
            }.frame(alignment: .leading)
        }.accessibilityElement(children: .combine)
            .font(DistrictDesign.Size.Font.DEFAULT)
    }
}
