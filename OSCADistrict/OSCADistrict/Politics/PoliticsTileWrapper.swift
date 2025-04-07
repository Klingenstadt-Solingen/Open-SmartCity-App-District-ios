import Foundation
import SwiftUI
import Factory

struct PoliticsTileWrapper: DashboardTileWrapper {
    var id: String = UUID().uuidString
    @State var navigationRoute = Route.politicDistricts
    @InjectedObject(\.districtViewModel) var districtViewModel
    
    var contentView: some View {
        DashboardDefaultTile(title: "politics_title", image: "ic_users")
            .onChange(of: districtViewModel.districtState) { _ in
                changeRoute()
            }.onAppear() {
                changeRoute()
            }
    }
    
    func changeRoute() {
        if case .district(let district) = districtViewModel.districtState {
            navigationRoute = Route.politicDistrictDetail(district)
        } else {
            navigationRoute = Route.politicDistricts
        }
    }
}
