import SwiftUI
import Factory
import MapKit
import SDWebImageSwiftUI

struct PoliticDistrictDetailScreen: View {
    var district: District
    @InjectedObject(\.politicDistrictDetailViewModel) var viewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: DistrictDesign.Spacing.DEFAULT) {
            TitleView(title: "politics_title")
                .padding(.horizontal, DistrictDesign.Padding.BIGGER)
            LoadingWrapper(loadingStates: viewModel.loadingState) {
                ScrollView {
                    if let organization = viewModel.organization {
                        VStack(alignment: .center, spacing: DistrictDesign.Spacing.DEFAULT) {
                            Text(organization.name)
                                .font(DistrictDesign.Size.Font.HEADLINE)
                                .padding(.horizontal, DistrictDesign.Padding.BIGGER)
                            WebImage(url: URL(string: getHttps(district.logo.url!)))
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 100)
                                .padding(.horizontal, DistrictDesign.Padding.BIGGER)
                            
                            if let major = organization.newestMayor {
                                VStack(spacing: DistrictDesign.Spacing.DEFAULT) {
                                    if let role = major.role {
                                        Text(role).font(DistrictDesign.Size.Font.DEFAULT).bold()
                                    }
                                    Text(major.person.name()).font(DistrictDesign.Size.Font.DEFAULT)
                                }.padding(.horizontal, DistrictDesign.Padding.BIGGER)
                            }
                                                        
                            PoiMapView(
                                districtState: DistrictState.district(district),
                                settings: PoiMapSettings(
                                    isScrollEnabled: false,
                                    isZoomEnabled: false,
                                    isPitchEnabled: false,
                                    isRotateEnabled: false,
                                    showsUserLocation: false,
                                    zoomSpace: 10,
                                    showsCompass: false,
                                    showsUserTrackingButton: false
                                )
                            ).frame(height: 200)
                            if let description = organization.location?.description {
                                Text(description).font(DistrictDesign.Size.Font.DEFAULT).padding(.horizontal, 18)
                            }

                            VStack(spacing: DistrictDesign.Spacing.DEFAULT) {
                                Text("council_members \(organization.memberCount)", bundle: OSCADistrict.bundle).font(DistrictDesign.Size.Font.DEFAULT)
                                Text("authorized_votes \(organization.votingMemberCount)", bundle: OSCADistrict.bundle).font(DistrictDesign.Size.Font.DEFAULT)
                            }.padding(.horizontal, DistrictDesign.Padding.BIGGER)
                            
                            getNavigationLink(
                                title: "politic_meetings",
                                route: Route.politicMeetings(organization.id, title: organization.name)
                            )
                            
                            getNavigationLink(
                                title: "politic_members",
                                route: Route.politicMembers(organization.id, title: organization.name)
                            )
                        }
                        .buttonStyle(GeneralButtonStyle())
                        .multilineTextAlignment(.center)
                        .padding(.vertical, DistrictDesign.Padding.MEDIUM)
                        Spacer()
                    }
                }
            }
        }.navigationBarTitleDisplayMode(.inline)
        .task(id: district) {
            await viewModel.getOrganization(district: district)
        }
    }
    
    @ViewBuilder
    func getNavigationLink(title: LocalizedStringKey, route: Route) -> some View {
        GeneralNavigationLink(route: route) {
            HStack(spacing: DistrictDesign.Spacing.DEFAULT) {
                Text(title, bundle: OSCADistrict.bundle).font(DistrictDesign.Size.Font.DEFAULT)
                Spacer()
            }.padding(DistrictDesign.Padding.MEDIUM)
                .padding(.leading, DistrictDesign.Padding.MEDIUM)
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, DistrictDesign.Padding.BIGGER)
    }
    
    // TODO: ADD HTTPS TO URL UNTIL ISSUE IS RESOLVED WITH PARSE SERVER
    func getHttps(_ url: String) -> String {
        var https = url
        if (!url.starts(with: "https")) {
            https = url.replacingOccurrences(of: "http", with: "https")
        }
        return https
    }
}
