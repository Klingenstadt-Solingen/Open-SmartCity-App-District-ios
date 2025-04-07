import SwiftUI
import Factory

struct PoliticMemberDetailScreen: View {
    var membership: PoliticMembership
    @InjectedObject(\.politicMemberDetailViewModel) var viewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: DistrictDesign.Spacing.BIG) {
            var person = membership.person
            VStack(alignment: .leading, spacing: DistrictDesign.Spacing.DEFAULT) {
                Text(person.name())
                    .font(DistrictDesign.Size.Font.HEADLINE)
                if let role = membership.role {
                    Text(role)
                        .font(DistrictDesign.Size.Font.NORMAL_TEXT)
                }
            }
            
            ForEach(person.email ?? [], id: \.self) { email in
                if let url = URL(string: "mailto:\(email)") {
                    Link(email, destination: url)
                }
            }
            
            ForEach(person.phone ?? [], id: \.self) { phone in
                if let url = URL(string: "tel:\(phone)") {
                    Link(phone, destination: url)
                }
            }
            
            if viewModel.items.endIndex > 0 {
                Text("memberships", bundle: OSCADistrict.bundle)
                    .font(DistrictDesign.Size.Font.SUB_SUB_TITLE.bold())
            }
            PaginationLoadingWrapper(loadingState: viewModel.loadingState) {
                LazyVStack(alignment: .leading, spacing: DistrictDesign.Spacing.BIG) {
                    ForEach(Array(viewModel.items.enumerated()), id: \.element) { index, membershipItem in
                        ZStack {
                            if let organizationName = membershipItem.organizationName, let role = membershipItem.role {
                                VStack(alignment: .leading, spacing: DistrictDesign.Spacing.DEFAULT) {
                                    Text(organizationName)
                                        .font(DistrictDesign.Size.Font.NORMAL_TEXT.bold())
                                    Text(role)
                                        .font(DistrictDesign.Size.Font.NORMAL_TEXT)
                                }
                            }
                        }.task(id: index) {
                            if index == viewModel.items.endIndex - 1 && viewModel.items.endIndex % viewModel.pageSize == 0  {
                                await viewModel.loadPage()
                            }
                        }
                    }
                }
            }.refreshableTask(id: membership.person.id, pageable: viewModel) {
                viewModel.personId = membership.person.id
            }
        }
        .padding(.horizontal, DistrictDesign.Padding.BIGGER)
        .padding(.vertical, DistrictDesign.Padding.MEDIUM)
        .frame(maxWidth: .infinity)
    }
}
