import SwiftUI
import SDWebImageSwiftUI

struct ProjectDetailScreen: View {
    @StateObject var viewModel = ProjectDetailViewModel()
    var objectId: String
    
    var body: some View {
        LoadingWrapper(loadingStates: viewModel.loadingState) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: DistrictDesign.Spacing.DEFAULT) {
                    Text(viewModel.project.name)
                        .font(DistrictDesign.Size.Font.HEADLINE).bold()
                    ProjectInfoView(project: viewModel.project)
                    Text(viewModel.project.summary)
                        .font(DistrictDesign.Size.Font.NORMAL_TEXT)
                    WebImage(url: URL(string: viewModel.project.image))
                        .resizable()
                        .indicator { _, _ in
                            ProgressView()
                        }
                        .transition(.fade)
                        .mask(DistrictDesign.ROUNDED_RECTANGLE)
                        .scaledToFit()
                        .frame(maxWidth: .infinity ,maxHeight: 200)
                    if viewModel.project.volume > 0 {
                        HStack(spacing: DistrictDesign.Spacing.DEFAULT) {
                            Image(systemName: "eurosign.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: DistrictDesign.Size.Icon.BIG)
                                .foregroundColor(.primary)
                            Text("\(viewModel.project.volume, specifier: "%.2f")€")
                                .font(DistrictDesign.Size.Font.NORMAL_TEXT)
                            Spacer()
                        }
                    }
                    Text(viewModel.project.content).font( DistrictDesign.Size.Font.SMALL_TEXT)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, DistrictDesign.Padding.BIGGER)
                .padding(.bottom, DistrictDesign.Padding.MEDIUM)
                
                ZStack {
                    VStack(spacing: DistrictDesign.Spacing.DEFAULT) {
                        if !viewModel.contacts.isEmpty {
                            ProjectContactPagerView(contacts: viewModel.contacts)
                        }
                        
                        ForEach(Array(viewModel.partnerMap.keys), id: \.self) { key in
                            if let partners = viewModel.partnerMap[key] {
                                ProjectPartnerPagerView(partnerCategory: key, partners: partners)
                           }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, DistrictDesign.Padding.MEDIUM)
                    .foregroundColor(.white)
                }
                .background(Color.primary.padding(.bottom, -UIScreen.main.bounds.height))
            }
        }
        .task() {
            await viewModel.getProject(objectId: objectId)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
