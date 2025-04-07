import SwiftUI

/**
 Wraps content inside of a loading circle until data is loaded
 */
struct LoadingWrapper<Content>: View where Content: View {
    @Environment(\.refresh) private var refresh
    var loadingStates: [LoadingState]
    var fillMaxHeight = true
    
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        switch getStatus(loadingStates: loadingStates) {
        case .initializing:
            HStack(spacing: DistrictDesign.Spacing.DEFAULT) {
                Spacer()
                VStack(spacing: DistrictDesign.Spacing.DEFAULT) {
                    if (fillMaxHeight) {
                        Spacer()
                    }
                    ProgressView()
                    if (fillMaxHeight) {
                        Spacer()
                    }
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
            content()
        }
    }
    
    /**
     Checks each loadable if it is loaded
     */
    func getStatus(loadingStates: [LoadingState]) -> LoadingState {
        for loadingState in loadingStates {
            switch loadingState {
            case .error(let errorMessage):
                return .error(errorMessage: errorMessage)
            case .initializing:
                return .initializing
            default:
                break
            }
        }
        
        return .loaded
    }
}


extension LoadingWrapper {
    init(
        loadingStates: LoadingState...,
        fillMaxHeight: Bool = false,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.init(loadingStates: loadingStates, fillMaxHeight: fillMaxHeight, content: content)
    }
}

#Preview {
    LoadingWrapper(loadingStates: .initializing) {
        Text("")
    }
}

