import Foundation
import MapKit
import SwiftUI

final class MapAnnotation<T, Content: View>: NSObject, MKAnnotation,Identifiable {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var annotationItem: T
    var content: MapMarkerView<Content>
    
    init(@ViewBuilder content: @escaping (T) -> MapMarkerView<Content>, annotationItem: T) {
        self.content = content(annotationItem)
        self.coordinate = self.content.coordinate
        self.title = self.content.title
        self.annotationItem = annotationItem
    }
}
