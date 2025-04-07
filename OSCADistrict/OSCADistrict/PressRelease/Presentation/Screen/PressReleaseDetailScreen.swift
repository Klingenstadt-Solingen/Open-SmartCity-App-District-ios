import SwiftUI
import SDWebImageSwiftUI


struct PressReleaseDetailScreen: View {
    @State var objectId: String
    @StateObject var viewModel = PressReleaseDetailViewModel()

    var body: some View {
        LoadingWrapper(loadingStates: viewModel.loadingState) {
            if let pressRelease = viewModel.pressRelease {
                ScrollView {
                    VStack(spacing: DistrictDesign.Spacing.MEDIUM) {
                        PressReleaseDetailHeadView(pressRelease: pressRelease)
                        VStack(alignment: .leading, spacing: DistrictDesign.Spacing.BIG) {
                            if let imageUrl = URL(string: pressRelease.imageUrl ?? "") {
                                WebImage(url: imageUrl)
                                    .resizable()
                                    .indicator { _, _ in
                                        ProgressView()
                                    }
                                    .transition(.fade)
                                    .scaledToFit()
                                    .clipShape(DistrictDesign.ROUNDED_RECTANGLE)
                                    .frame(maxHeight: 200)
                            }
                            HtmlText(html: pressRelease.content)
                        }.padding(.bottom, DistrictDesign.Padding.MEDIUM)
                    }.padding(.horizontal, DistrictDesign.Padding.BIGGER)
                }
            }
        }.task(id: objectId) {
            await viewModel.getPressReleaseById(objectId)
        }.navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    PressReleaseDetailScreen(objectId: "")
}
