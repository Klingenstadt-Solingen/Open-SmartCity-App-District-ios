import SwiftUI

import ParseCore
import Foundation
import CoreLocation
import SDWebImageSwiftUI

struct EventDetailScreen: View {
    var objectId: String
    @StateObject var viewModel = EventDetailViewModel()
    @EnvironmentObject var locationViewModel: LocationViewModel

    var body: some View {
        LoadingWrapper(loadingStates: viewModel.loadingState) {
            ScrollView {
                VStack(spacing: DistrictDesign.Spacing.DEFAULT) {
                    EventDetailHead(event: viewModel.event)
                    VStack(spacing: DistrictDesign.Spacing.BIG) {
                        if viewModel.event.image != nil {
                            WebImage(url: URL(string: viewModel.event.image!))
                                .resizable()
                                .indicator { _, _ in
                                    ProgressView()
                                }
                                .transition(.fade)
                                .scaledToFit()
                                .clipShape(DistrictDesign.ROUNDED_RECTANGLE)
                                .frame(maxHeight: 200)
                        }
                        let details = EventDetails(
                            viewModel.event
                        )
                        Divider().frame(minHeight: 2).background(Color.primary)
                        EventDetailButtonBarView()
                        Divider().frame(minHeight: 2).background(Color.primary)
                        HtmlText(html: details.description).frame(maxWidth: .infinity)

                        if !details.prices.isEmpty {
                            EventPricesView(prices: details.prices)
                        }
                        EventOpeningHoursView()
                        LocationNavigationView(
                            locationDescription: details.name,
                            latitude: viewModel.event.geopoint.latitude,
                            longitude: viewModel.event.geopoint.longitude
                        )
                        EventDetailPocketMapView(event: viewModel.event , eventBooths: viewModel.eventBooths)
                    }.padding(.bottom, DistrictDesign.Padding.MEDIUM)
                }.padding(.horizontal, DistrictDesign.Padding.BIGGER)
                if viewModel.eventSponsors.count > 0 {
                    ZStack {
                        VStack(spacing: DistrictDesign.Spacing.DEFAULT) {
                            EventSponsorPagerView(sponsors: viewModel.eventSponsors)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, DistrictDesign.Padding.MEDIUM)
                        .foregroundColor(.white)
                    }
                    .background(Color.primary.padding(.bottom, -UIScreen.main.bounds.height))
                }
            }
        }.task(id: objectId) {
            await viewModel.getEvent(objectId: objectId)
        }.navigationBarTitleDisplayMode(.inline)
            .frame(maxHeight: .infinity, alignment: .top)
            .environmentObject(viewModel)
    }
}


#Preview {
    EventDetailScreen(objectId: "")
}
