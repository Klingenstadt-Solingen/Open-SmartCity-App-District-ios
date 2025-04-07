import SwiftUI

struct ReadingTimeView: View {
    var readingTime: Int
    
    var body: some View {
        HStack(spacing: DistrictDesign.Spacing.DEFAULT) {
            Image("ic_timer", bundle: OSCADistrict.bundle)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: DistrictDesign.Size.Icon.BIG, maxHeight: DistrictDesign.Size.Icon.BIG)
                .foregroundColor(Color.primary)
            Text(
                "reading_time \(readingTime, specifier: "%lld")",
                bundle: OSCADistrict.bundle
            ).font(DistrictDesign.Size.Font.NORMAL_TEXT)
        }.accessibilityElement(children: .combine)
            .accessibilityLabel(
                Text("reading_time \(readingTime, specifier: "%lld")",
                bundle: OSCADistrict.bundle)
                .font(DistrictDesign.Size.Font.DEFAULT)
            )
    }
}


#Preview {
    ReadingTimeView(readingTime: 5)
}
