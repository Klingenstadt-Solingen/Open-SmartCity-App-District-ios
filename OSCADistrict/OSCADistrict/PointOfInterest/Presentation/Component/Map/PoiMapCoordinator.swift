import SwiftUI
import MapKit

/**
 Manages interactions between the Map and View
 
 - Parameters:
    - mapVC: Map Viewcontroller
    - regionChanged: Function called when the shown region changes
    - annotationAction: Function called  when an Annotation is clicked
 */
class PoiMapCoordinator<T: Equatable, Content: View>: NSObject, MKMapViewDelegate {
    var districtState: DistrictState?
    var districtOverlay: DistrictPolygon?
    var annotationItems: [T] = []
    var annotations: [PoiAnnotation<T, Content>] = []
        
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if let annotation = annotation as? PoiAnnotation<T, Content> {
            let identifier = annotation.content.identifier
            
            if let annotation = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
                return annotation
            }
            
            return PoiAnnotationView<T, Content>(
                poiAnnotation: annotation,
                reuseIdentifier: identifier
            )
        }
        return nil //mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier, for: annotation)
    }


    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyOverlay = overlay as? MKPolygon {
            let polyRender = MKPolygonRenderer(polygon: polyOverlay)
            polyRender.strokeColor = UIColor(Color.primary)
            polyRender.lineWidth = 4
            polyRender.alpha = 0.8
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
        return MKPolygonRenderer()
    }
}

