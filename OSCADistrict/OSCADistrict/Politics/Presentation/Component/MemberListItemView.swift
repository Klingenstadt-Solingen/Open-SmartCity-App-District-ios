import SwiftUI

struct MemberListItemView: View {
    var membership: PoliticMembership
    
    var body: some View {
        VStack(alignment: .leading, spacing: DistrictDesign.Spacing.DEFAULT) {
            Text(membership.person.name())
                .font(DistrictDesign.Size.Font.SUB_SUB_TITLE)
            Text(membership.role ?? "")
                .font(DistrictDesign.Size.Font.NORMAL_TEXT)
        }.padding(DistrictDesign.Padding.MEDIUM)
            .padding(.leading, DistrictDesign.Padding.MEDIUM)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
