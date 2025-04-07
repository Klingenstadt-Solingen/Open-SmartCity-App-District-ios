import SwiftUI

struct ProjectStatusView: View {
    var status: ProjectStatus?
    
    var body: some View {
        let semanticsStatus = Text("status", bundle: OSCADistrict.bundle) + Text(": ")
        
        HStack(spacing: DistrictDesign.Spacing.DEFAULT) {
            Image("ic_cog", bundle: OSCADistrict.bundle)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: DistrictDesign.Size.Icon.BIG)
                .foregroundColor(.primary)
                .accessibilityLabel(semanticsStatus)
            Text(ProjectStatus.titleOf(status: status), bundle: OSCADistrict.bundle).font(DistrictDesign.Size.Font.NORMAL_TEXT)
        }
        .accessibilityElement(children: .combine)
    }
}
