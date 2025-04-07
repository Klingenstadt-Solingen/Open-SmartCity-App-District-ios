import SwiftUI
import MapKit

/**
 Manages interactions between the Map and View
 
 - Parameters:
    - mapVC: Map Viewcontroller
    - regionChanged: Function called when the shown region changes
    - annotationAction: Function called  when an Annotation is clicked
 */
class MapCoordinator<T: Equatable, Content: View>: NSObject, MKMapViewDelegate {
    var activateMenue: Bool = false
    var districtState: DistrictState?
    var districtOverlay: DistrictPolygon?
    var annotationItems: [T] = []
    var annotations: [MapAnnotation<T, Content>] = []
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? MapAnnotation<T, Content> {
            let identifier = annotation.content.identifier
            
            if let annotation = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
                return annotation
            }
            
            return MapAnnotationView<T, Content>(
                mapAnnotation: annotation,
                reuseIdentifier: identifier
            )
        }
        return nil
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyOverlay = overlay as? MKPolygon {
            let polyRender = MKPolygonRenderer(polygon: polyOverlay)
            polyRender.strokeColor = .yellow//UIColor(Color.primary)
            polyRender.lineWidth = 4
            polyRender.fillColor = .yellow
            return polyRender
        } else if let district = overlay as? DistrictPolygon {
            let polyRender = MKPolygonRenderer(polygon: district)
            polyRender.strokeColor = UIColor(Color.primary)
            polyRender.lineWidth = 4
            return polyRender
        } else if let tileOverlay = overlay as? MKTileOverlay {
            return  MKTileOverlayRenderer(overlay: tileOverlay)
        }
        if let circleOverlay = overlay as? MKCircle {
            let circleRenderer = MKCircleRenderer(overlay: circleOverlay)
            let systemBlueBorder = UIColor.systemBlue.withAlphaComponent(0.8)
            let systemBlueFill = UIColor.systemBlue.withAlphaComponent(0.3)
            circleRenderer.strokeColor = systemBlueBorder
            circleRenderer.lineWidth = 1.0
            circleRenderer.fillColor = systemBlueFill
            return circleRenderer
        }
        if let routePolyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: routePolyline)
            renderer.strokeColor = UIColor.systemBlue
            renderer.lineWidth = 5
            return renderer
        }
        return MKPolygonRenderer()
    }
    
    func mapView(_ mapView: MKMapView, annotationCanShowCallout annotation: MKAnnotation) -> Bool {
       return true
    }
}
