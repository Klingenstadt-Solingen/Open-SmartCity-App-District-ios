import SwiftUI
import SDWebImageSwiftUI


struct Navigation: View {
    @Environment(\.dismiss) private var dismiss
    @State var path: [Route] = []
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack(path: $path) {
                // TODO: Abstract set
                DashboardScreen().navigationDestination(for: Route.self ) { route in
                        ZStack {
                            switch route {
                            case .pressReleases:
                                PressReleaseListScreen()
                            case .pressReleaseDetail(let objectId):
                                PressReleaseDetailScreen(objectId: objectId)
                            case .event:
                                EventListScreen()
                            case .eventDetail(let objectId):
                                EventDetailScreen(objectId: objectId)
                            case .eventMapDetail(let objectId):
                                EventDetailMapScreen(objectId: objectId)
                            case .project:
                                ProjectGridScreen()
                            case .projectDetail(let objectId):
                                ProjectDetailScreen(objectId: objectId)
                            case .poiMap(let categoryId):
                                PoiMapScreen(categoryId: categoryId)
                            case .weather:
                                WeatherScreen()
                            case .mobility:
                                MobilityMapScreen()
                            case .mobilityVehicleDetailScreen(let objectId):
                                EmptyView()
                            case .mobilityStationDetailScreen(let objectId):
                                EmptyView()
                            case .politicDistricts:
                                PoliticDistrictListScreen()
                            case .politicDistrictDetail(let district):
                                PoliticDistrictDetailScreen(district: district)
                            case .politicMeetings(let organizationId, let title):
                                EmptyView()
                                PoliticMeetingListScreen(organizationId: organizationId, title: title)
                            case .politicMeetingDetail(let meeting):
                                EmptyView()
                                PoliticMeetingDetailScreen(meeting: meeting)
                            case .politicMembers(let organizationId, let title):
                                PoliticMemberListScreen(organizationId: organizationId, title: title)
                            case .politicMemberDetail(let membership):
                                PoliticMemberDetailScreen(membership: membership)
                            case .districtDiashow:
                                DistrictDiashowScreen()
                            case .standaloneRoute:
                                // upon entering this route the district module is dismissed
                                ProgressView().onAppear {
                                    dismiss()
                                }
                            }
                        }.toolbar {
                            ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                                DistrictToolbar()
                            }
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                            DistrictToolbar()
                        }
                    }
            }.task(id: "\(path)") {
                DistrictMatomo.shared.trackRoute(path)
            }
        }
    }
}

#Preview {
    Navigation()
}
