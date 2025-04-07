import Foundation
import SDWebImageSwiftUI
import SwiftUI
import Factory

struct DashboardScreen: View {
    @InjectedObject(\.districtViewModel) var districtViewModel

    var body: some View {
        VStack(spacing: DistrictDesign.Spacing.DEFAULT) {
            if #available(iOS 16.0, *) {
                ScrollView {
                    VStack(spacing: DistrictDesign.Spacing.DEFAULT) {
                        DashboardWidgetList()
                        DashboardTileGrid()
                    }
                    .padding(.horizontal, DistrictDesign.Padding.BIGGER)
                    .padding(.bottom, DistrictDesign.Padding.MEDIUM)
                    .background(createBackground())
                }
            }
        }.frame(maxWidth: .infinity).task(id: "\(districtViewModel.districtState)") {
            await districtViewModel.fetchDiashowCount()
        }
        .background(createBackground())
        .background(DashboardImage().accessibilityHidden(true))
        .navigationTitle(getTitle(state: districtViewModel.districtState))
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            if districtViewModel.diashowCount > 0 {
                GeneralNavigationLink(route: .districtDiashow){
                    Image(systemName: "play.square")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.primary)
                        .padding(DistrictDesign.Padding.SMALL)
                        .accessibilityLabel(Text("district_diashow_button", bundle: OSCADistrict.bundle))
                }.frame(width: 35, height: 35, alignment: .center)
                .background(
                    RoundedRectangle(
                        cornerRadius: DistrictDesign.CORNER_RADIUS
                    )
                        .fill(Color.accentColor)
                        .scaledToFill()
                
                )
            }
        }
    }

    @ViewBuilder
    private func createBackground() -> some View {
        DistrictDesign.ROUNDED_RECTANGLE
            .fill(.white)
            .offset(y: 45)
    }

    private func getTitle(state: DistrictState) -> String {
        if case .district(let district) = state {
            return String(localized: "district \(district.name)", bundle: OSCADistrict.bundle)
        } else {
            return String(localized: "city_name", bundle: OSCADistrict.bundle)
        }
    }
}

#Preview {
    DashboardScreen()
}
