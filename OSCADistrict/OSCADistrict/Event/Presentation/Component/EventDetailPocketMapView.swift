import SwiftUI
import MapKit

struct EventDetailPocketMapView: View {
    var event: Event
    var eventBooths: [EventBooth] = []
    @EnvironmentObject var locationViewModel: LocationViewModel
    @State var route: MKRoute? = nil
    var locationCoordinate2D: CLLocationCoordinate2D
    var region: MKCoordinateRegion

    var mapSettings = MapSettings(
        isScrollEnabled: false,
        isZoomEnabled: false,
        isPitchEnabled: false,
        isRotateEnabled: false,
        showsUserLocation: true,
        zoomSpace: 50
    )
    
    init(event: Event, eventBooths: [EventBooth]) {
        self.event = event
        self.eventBooths = eventBooths
        self.locationCoordinate2D = event.geopoint.toCLLocationCoordinate2D()
        self.region = MKCoordinateRegion(
            center: locationCoordinate2D,
            span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)
        )
    }

    var body: some View {
        GeneralNavigationLink(route: .eventMapDetail(event.id)) {
            MapView(
                annotationItems: eventBooths,
                overlays: eventBooths.map { eventBooth in
                    return MKPolygon(coordinates: eventBooth.area.coordinates().map{ coordinate in
                        return coordinate.toCLLocationCoordinate2D()
                    }, count: eventBooth.area.coordinates().count)
                },
                region: region,
                route: route,
                settings: mapSettings,
                eventAnnotation: MKPointAnnotation(
                    __coordinate: locationCoordinate2D,
                    title: event.name,
                    subtitle: String(localized: "entrance", bundle: OSCADistrict.bundle)
                )
            ) { eventBooth in
                MapMarkerView(
                    title: eventBooth.name,
                    coordinate: eventBooth.geopoint.toCLLocationCoordinate2D(),
                    identifier: eventBooth.id
                ) {
                    MapMarkerContentView(
                        url: eventBooth.type?.icon.url,
                        entity: eventBooth,
                        title: eventBooth.name
                    )
                }
            }.frame(maxWidth: .infinity)
                .aspectRatio(1 ,contentMode: .fit)
                .clipShape(DistrictDesign.ROUNDED_RECTANGLE)
        }
        .disabled(eventBooths.isEmpty)
        .task {
            route = await locationViewModel.getRouteToCoordinate(coordinate: locationCoordinate2D)
        }
    }
}
