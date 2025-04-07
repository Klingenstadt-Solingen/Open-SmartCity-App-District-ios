import SwiftUI

struct PaginationLoadingWrapper<Content>: View where Content: View {
    @Environment(\.refresh) private var refresh
    var axis: Axis.Set = .vertical
    var loadingState: LoadingState
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        switch (loadingState) {
        case .initializing:
            HStack(spacing: DistrictDesign.Spacing.DEFAULT) {
                Spacer()
                VStack(spacing: DistrictDesign.Spacing.DEFAULT) {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                Spacer()
            }
        case .error(let error):
            HStack(spacing: DistrictDesign.Spacing.DEFAULT) {
                Spacer()
                VStack(spacing: DistrictDesign.Spacing.DEFAULT) {
                    Spacer()
                    Text(error, bundle: OSCADistrict.bundle).font(DistrictDesign.Size.Font.DEFAULT)
                    if let refresh = refresh {
                        Button(action: {
                            Task {
                                await refresh()
                            }
                        }) {
                            Text("try_again", bundle: OSCADistrict.bundle).padding(DistrictDesign.Padding.MEDIUM)
                        }.buttonStyle(GeneralButtonStyle())
                    }
                    Spacer()
                }
                Spacer()
            }
        default:
            ScrollView(axis) {
                content()
                if loadingState == .paginating {
                    HStack(spacing: DistrictDesign.Spacing.DEFAULT) {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }.padding(.bottom, DistrictDesign.Padding.MEDIUM)
                }
            }
        }
    }
}
