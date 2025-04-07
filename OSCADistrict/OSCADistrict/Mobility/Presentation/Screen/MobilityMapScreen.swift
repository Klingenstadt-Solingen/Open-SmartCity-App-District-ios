import CoreLocation
import Factory
import Foundation
import MapKit
import ParseCore
import SDWebImageSwiftUI
import SwiftUI

@available(iOS 16.0, *)
struct MobilityMapScreen: View {
    @InjectedObject(\.mobilityMapViewModel) var viewModel

    private static var customSheetDetent: PresentationDetent = .fraction(0.65)

    @State private var sheetDetent = MobilityMapScreen.customSheetDetent
    @State private var showingSheet = true

    var mapSettings = MapSettings(
        isScrollEnabled: true,
        isZoomEnabled: true,
        isPitchEnabled: true,
        isRotateEnabled: true,
        showsUserLocation: true,
        zoomSpace: 20,
        showsCompass: true,
        showsUserTrackingButton: true
    )

    var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.17343, longitude: 7.0845),
        span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)
    )

    var body: some View {
        MapView(
            annotationItems: viewModel.mobilityObjects,
            settings: mapSettings,
            region: region
        ) { mobilityObject in
            return switch mobilityObject {
            case .vehicleStation(let station):
                MapMarkerView(
                    title: station.name,
                    coordinate: CLLocationCoordinate2D(
                        latitude: station.geopoint.x,
                        longitude: station.geopoint.y
                    ),
                    identifier: station.id
                ) {
                    MapMarkerContentView(
                        url: station.iconUrl ?? "", entity: mobilityObject,
                        title: station.name
                    ) { mobilityObject in
                        viewModel.selectedMobilityObject = mobilityObject
                    }
                }
            case .vehicle(let vehicle):
                MapMarkerView(
                    title: vehicle.name,
                    coordinate: CLLocationCoordinate2D(
                        latitude: vehicle.geopoint.x,
                        longitude: vehicle.geopoint.y
                    ),
                    identifier: vehicle.id
                ) { 
                    MapMarkerContentView(
                        url: vehicle.iconUrl ?? "",
                        entity: mobilityObject,
                        title: vehicle.name
                    ) { mobilityObject in
                        viewModel.selectedMobilityObject = mobilityObject
                    }
                }
            }
        }
        .frame(width: .infinity, height: .infinity, alignment: .center)
        .task {
            await viewModel.initTypes()
        }.navigationBarTitleDisplayMode(.inline)
        .onChange(of: viewModel.mobilityTypes) { mobilityTypes in
            showingSheet = !mobilityTypes.isEmpty
        }
        .sheet(isPresented: $showingSheet) {
            NavigationStack {
                if #available(iOS 16.4, *) {
                    MobilitySearchSheet()
                        .presentationDetents(
                            [
                                MobilityMapScreen.customSheetDetent,
                                .fraction(0.1),
                                .large
                            ], selection: $sheetDetent
                        )
                        .presentationBackgroundInteraction(
                            .enabled(upThrough: .large)
                        )
                        .presentationCompactAdaptation(.none)
                        .interactiveDismissDisabled()
                        .padding(.top, DistrictDesign.Padding.BIG)
                }
            }
        }
    }
}

#Preview {
    EventDetailMapScreen(objectId: "")
}

