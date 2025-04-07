import SwiftUI
import SDWebImageSwiftUI
import ParseCore
import Foundation
import Factory

import MapKit
import CoreLocation


struct MobilityVehicleDetailScreen: View {
    @InjectedObject(\.mobilityMapViewModel) var viewModel
    @EnvironmentObject var locationViewModel: LocationViewModel

    var body: some View {
        LoadingWrapper(loadingStates: viewModel.loadingState) {

        }.task() {
            //await viewModel.fetchVehicleObjects()
        }.navigationBarTitleDisplayMode(.inline)
        .frame(maxHeight: .infinity, alignment: .top)
        .environmentObject(locationViewModel)
    }
}


#Preview {
    //MobilityVehicleDetailScreen(objectId: "")
}
