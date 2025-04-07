import SwiftUI
import MarkdownUI
import SDWebImageSwiftUI
import CoreLocation
import Factory

struct MobilitySearchSheet: View {
    @InjectedObject(\.mobilityMapViewModel) var viewModel
    @StateObject var mobilityAddressViewModel = MobilityAddressViewModel()
    @State private var focus: Bool = false
    
    func getDefaultIconUrl() -> String {
        if let selectedMobilityType = viewModel.selectedMobilityType {
            return selectedMobilityType.iconUrl
        }
        return ""
    }

    var body: some View {
        VStack(spacing: DistrictDesign.Spacing.DEFAULT) {
            /*HStack {
             Image(systemName: "magnifyingglass")
             TextField("Suche", text: $$mobilityAddressViewModel.searchText, onEditingChanged: { state in
             focus = state
             }, onCommit: {
             focus = false
             })
             }.padding(DistrictDesign.Padding.BIG)
             .frame(maxWidth: .infinity, alignment: .center)
             .background(Color.gray.opacity(0.1))
             .clipShape(DistrictDesign.ROUNDED_RECTANGLE)
             .padding(.horizontal, DistrictDesign.Padding.BIGGER)
             */
            
            if (focus) {
                MobilityAddressSearchView().environmentObject(mobilityAddressViewModel)
                /*
                MobilityDefaultSearchItem()
                    .padding(.horizontal, DistrictDesign.Padding.BIGGER)*/
            } else {
                HStack {
                    VStack {
                        Text("ausgewählter Startort Adresse").font(DistrictDesign.Size.Font.NORMAL_TEXT).bold()
                            .lineLimit(2)
                    }.frame(maxWidth: .infinity, alignment: .center)
                    VStack {
                        SelectableButton(
                            action: { },
                            selected: false,
                            disableable: false
                        ) {
                            HStack {
                                Image("ic_navigation", bundle: OSCADistrict.bundle)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: DistrictDesign.Size.Icon.BIG, maxHeight: DistrictDesign.Size.Icon.BIG)
                                    .foregroundColor(.primary)
                                    .padding(DistrictDesign.Padding.MEDIUM)
                                Text("Route")//, bundle: OSCADistrict.bundle)
                                    .font(DistrictDesign.Size.Font.DEFAULT)
                            }.padding(.horizontal, DistrictDesign.Padding.DEFAULT)
                        }
                    }.frame(maxWidth: .infinity, alignment: .trailing)
                }
                .frame(alignment: .trailing)
                .padding(.horizontal, DistrictDesign.Padding.BIGGER)
                
                TabBar(
                    mobilityTypes: viewModel.mobilityTypes,
                    selectedMobilityType: $viewModel.selectedMobilityType
                )
                    .padding(.horizontal, DistrictDesign.Padding.BIGGER)
                    .frame(width: .infinity)
                
                PaginationLoadingWrapper(loadingState: viewModel.loadingState) {
                    LazyVStack(spacing: DistrictDesign.Spacing.DEFAULT) {
                        ForEach(viewModel.mobilityObjects, id: \.self) { object in
                            switch object {
                            case .vehicleStation(let station):
                                StationListItem(
                                    station: station,
                                    defaultIconUrl: getDefaultIconUrl()
                                )
                                
                            case .vehicle(let vehicle):
                                VehicleListItem(
                                    vehicle: vehicle,
                                    defaultIconUrl: getDefaultIconUrl()
                                )
                            }
                        }
                    }
                    .padding(.horizontal, DistrictDesign.Padding.BIGGER)
                    .padding(.vertical, DistrictDesign.Padding.MEDIUM)
                }.frame(height: .infinity)
            }
        }.searchable(text: $viewModel.searchText)
        //.navigationBarTitle("")
        .navigationBarHidden(true)
        .task(id: viewModel.selectedMobilityType?.id) {
            if let typeId = viewModel.selectedMobilityType?.id {
                await viewModel.getVehciles(typeId: typeId)
            }
        }
    }
}
