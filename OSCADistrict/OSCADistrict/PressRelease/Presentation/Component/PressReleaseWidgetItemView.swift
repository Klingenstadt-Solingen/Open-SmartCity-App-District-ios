import SwiftUI

struct PressReleaseWidgetItemView: View {
    var pressRelease: PressRelease
    
    var body: some View {
        GeneralNavigationLink(route: .pressReleaseDetail(pressRelease.id)) {
            HStack(alignment: .firstTextBaseline, spacing: DistrictDesign.Spacing.MEDIUM) {
                Spacer()
                Image("ic_right", bundle: OSCADistrict.bundle)
                    .resizable()
                    .scaledToFit()
                    .frame(height: DistrictDesign.Size.Icon.SMALL)
                    .foregroundColor(Color.accentColor)
                Text(pressRelease.title)
                    .multilineTextAlignment(.center)
                    .font(DistrictDesign.Size.Font.SUB_SUB_TITLE.bold())
                Spacer()
            }
        }
        .foregroundColor(Color.black)
    }
}

#Preview {
    PressReleaseWidgetItemView(pressRelease: PressRelease())
}
