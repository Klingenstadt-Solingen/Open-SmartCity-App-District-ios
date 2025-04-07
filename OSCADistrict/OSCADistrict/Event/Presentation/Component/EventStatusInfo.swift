import SwiftUI

struct EventStatusInfo: View {
    var statusKey: LocalizedStringKey
    var systemImageName: String
    var color: Color
    
    var body: some View {
        HStack(spacing: DistrictDesign.Spacing.DEFAULT) {
            Image(systemName: systemImageName)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: DistrictDesign.Size.Icon.BIG)
                .foregroundColor(color)
            Text(statusKey, bundle: OSCADistrict.bundle)
                .font(DistrictDesign.Size.Font.HEADLINE)
                .foregroundColor(color)
                .lineLimit(1)
        }
    }
}
