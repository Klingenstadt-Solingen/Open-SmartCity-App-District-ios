import SwiftUI
import Factory
import Foundation
import CoreLocation
import SDWebImageSwiftUI

struct DistrictDiashowScreen: View {
    @EnvironmentObject var districtViewModel: DistrictViewModel
    @StateObject var districtDiashowViewModel = DistrictDiashowViewModel()
    
    var body: some View {
        LoadingWrapper(loadingStates: districtDiashowViewModel.loadingState) {
            Pager(
                data: districtDiashowViewModel.diashowObjects,
                selectedPage: $districtDiashowViewModel.selectedPage
            ) { diashowObject in
                VStack {
                    if let fileUrl = diashowObject.file?.url {
                        WebImage(url: URL(string: fileUrl))
                            .resizable()
                            .indicator { isAnimating, progress in
                                ProgressView(value: progress.wrappedValue)
                            }
                            .scaledToFit()
                            .transition(.fade(duration: 0.5))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        //Text(verbatim: diashowObject.getDescription() ?? "")
                    }
                
                }.task(id: diashowObject.id) {
                    districtDiashowViewModel.start(diashowObject.duration)
                }.accessibilityLabel(diashowObject.description)
                    .accessibilityElement(children: .combine)
            }
        }.task(id: "\(districtViewModel.districtState)") {
            if case .district(let district) = districtViewModel.districtState {
                await districtDiashowViewModel.initFetch(diashowConfig: district.diashowConfig)
            } else {
                await districtDiashowViewModel.setDistrictlessState()
            }
        }
    }
}
