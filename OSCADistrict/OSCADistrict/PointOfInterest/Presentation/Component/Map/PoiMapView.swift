import SwiftUI
import MapKit

/**
 Map View showing Simple Annotations for OSCA
 This view uses Features that are not available in IOS 16
 This shoud be refactored or removed if the current version has all features that are required

 - Parameters:
    - region: Inital region on the map
    - annotationItems: List of Object containing needed Infos to show Annotaitions
    - settings: Settings of the Map
    - region: Inital start region
    - content: Marker View that defines the visable Marker on the map
*/
// TODO: Refactor to make more Generic and less messy 
struct PoiMapView<T: Equatable, Content: View>: UIViewRepresentable {
    var districtState: DistrictState = .all
    var annotationItems: [T] = []
    var settings: PoiMapSettings = PoiMapSettings()
    var region: MKCoordinateRegion?
    
    @ViewBuilder var content: (T) -> PoiMapMarkerView<Content>
    
    func makeCoordinator() -> PoiMapCoordinator<T, Content> {
        PoiMapCoordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let view = MKMapView(frame: .zero)
        view.delegate = context.coordinator
        if let region = region {
            view.region = region
        }
        view.mapType = .mutedStandard
        view.pointOfInterestFilter = .excludingAll
        view.cameraZoomRange = MKMapView.CameraZoomRange(minCenterCoordinateDistance: 500)
        
        let underlay = PoiTileOverlay()
        underlay.canReplaceMapContent = true
        view.addOverlay(underlay)
        
        view.isScrollEnabled = settings.isScrollEnabled
        view.isZoomEnabled = settings.isZoomEnabled
        view.isPitchEnabled = settings.isPitchEnabled
        view.isRotateEnabled = settings.isRotateEnabled
        view.showsUserLocation = settings.showsUserLocation
        view.showsCompass = settings.showsCompass
        if #available(iOS 17.0, *) {
            view.showsUserTrackingButton = settings.showsUserTrackingButton
        }
        return view
    }
    
    func findNearbyCircle(_ view: MKMapView) -> MKCircle? {
        for overlay in view.overlays {
            if let oldCircle = overlay as? MKCircle {
                return oldCircle
            }
        }
        return nil
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        if districtState != context.coordinator.districtState {
            if let districtOverlay = context.coordinator.districtOverlay {
                view.removeOverlay(districtOverlay)
            }
            
            if case .district(let district) = districtState {
                let districtPolygon = DistrictPolygon(district: district)
                view.insertOverlay(districtPolygon, at: 1)
                context.coordinator.districtOverlay = districtPolygon
                zoom(view, for: districtPolygon)
            }
            if let circle = findNearbyCircle(view) {
                view.removeOverlay(circle)
            }
            if case .nearby(let location, let range) = districtState {
                if Double(range) < OSCADistrictSettings.shared.maxDistanceRange {
                    let locationCoordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                    let circle = MKCircle(center: locationCoordinate, radius: Double(range * 1000))
                    view.insertOverlay(circle, at: 2)
                    zoom(view, for: circle)
                }
            }
            
            context.coordinator.districtState = districtState
        }
        
     
        if annotationItems != context.coordinator.annotationItems {
            let annotations = annotationItems.map { annotationItem in
                return PoiAnnotation(content: content, annotationItem: annotationItem)
            }
            view.removeAnnotations(context.coordinator.annotations)
            view.addAnnotations(annotations)
            context.coordinator.annotationItems = annotationItems
            context.coordinator.annotations = annotations
        }
    }
    
    func zoom(_ mapView: MKMapView, for overlay: MKOverlay) {
        let zoomSpace = settings.zoomSpace
        mapView.setVisibleMapRect(
            overlay.boundingMapRect,
            edgePadding: UIEdgeInsets(top: zoomSpace, left: zoomSpace, bottom: zoomSpace, right: zoomSpace), 
            animated: true
        )
    }
}



extension PoiMapView where Content == EmptyView, T == EmptyAnnotationValue {
    init(
        districtState: DistrictState,
        region: MKCoordinateRegion? = nil,
        settings: PoiMapSettings = PoiMapSettings()
    ) {
        self.districtState = districtState
        self.region = region
        self.content = { _ in PoiMapMarkerView()}
        self.settings = settings
    }
}

extension PoiMapView {
    init(
        districtState: DistrictState,
        annotationItems: [T] = [],
        region: MKCoordinateRegion? = nil,
        settings: PoiMapSettings = PoiMapSettings(),
        content: @escaping (T) -> PoiMapMarkerView<Content>
    ) {
        self.districtState = districtState
        self.annotationItems = annotationItems
        self.region = region
        self.content = content
        self.settings = settings
    }
}
