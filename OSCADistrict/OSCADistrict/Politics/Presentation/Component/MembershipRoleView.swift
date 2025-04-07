import SwiftUI
import Factory

struct MembershipRoleView: View {
    @State var organizationName: String? = nil
    @State var loadingState: LoadingState = .initializing
    var role: String?
    
    var body: some View {
        if let organizationName = organizationName, let role = role {
            VStack(alignment: .leading, spacing: DistrictDesign.Spacing.DEFAULT) {
                Text(organizationName)
                    .font(DistrictDesign.Size.Font.NORMAL_TEXT.bold())
                Text(role)
                    .font(DistrictDesign.Size.Font.NORMAL_TEXT)
            }
        }
    }
}
