import Foundation
import MapKit
import SwiftUI

final class PoiAnnotation<T, Content: View>: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var annotationItem: T
    var content: PoiMapMarkerView<Content>
    
    init(@ViewBuilder content: @escaping (T) -> PoiMapMarkerView<Content>, annotationItem: T) {
        self.content = content(annotationItem)
        self.coordinate = self.content.coordinate
        self.title = self.content.title
        self.annotationItem = annotationItem
    }
}
