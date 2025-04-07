import SwiftUI
import SDWebImageSwiftUI
import ParseCore
import Foundation

import MapKit
import CoreLocation

struct EventDetailMapScreen: View {
    var objectId: String
    @StateObject var viewModel = EventDetailViewModel()
    @EnvironmentObject var locationViewModel: LocationViewModel

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

    var body: some View {
        LoadingWrapper(loadingStates: viewModel.loadingState) {
            var region = MKCoordinateRegion(
                center: viewModel.event.geopoint.toCLLocationCoordinate2D(),
                span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)
            )

            MapView(
                annotationItems: viewModel.eventBooths,
                overlays: viewModel.eventBooths.map { eventBooth in
                    var coords = eventBooth.area.coordinates()
                    return MKPolygon(coordinates: coords.map { coordinate in
                        return coordinate.toCLLocationCoordinate2D()
                    }, count: coords.count)
                },
                settings: mapSettings,
                region: region,
                eventAnnotation: MKPointAnnotation(
                    __coordinate: viewModel.event.geopoint.toCLLocationCoordinate2D(),
                    title: viewModel.event.name,
                    subtitle: String(localized: "entrance", bundle: OSCADistrict.bundle)
                )
            ) { eventBooth in
                MapMarkerView(
                    title: eventBooth.name,
                    coordinate: eventBooth.geopoint.toCLLocationCoordinate2D(),
                    identifier: eventBooth.id
                ) {
                    MapMarkerContentView(url: eventBooth.type?.icon.url, entity: eventBooth, title: eventBooth.name) { eventBooth in
                        viewModel.selectedEventBooth = eventBooth
                    }
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .sheet(item: $viewModel.selectedEventBooth) { selectedEventBooth in
                if #available(iOS 16.0, *) {
                    EventBoothDetailSheet(eventBooth: selectedEventBooth).presentationDetents([.medium,.large])
                }
            }
        }.task(id: objectId) {
            await viewModel.getEvent(objectId: objectId)
        }.navigationBarTitleDisplayMode(.inline)
        .frame(maxHeight: .infinity, alignment: .top)
        .environmentObject(locationViewModel)
    }
}


#Preview {
    EventDetailMapScreen(objectId: "")
}
