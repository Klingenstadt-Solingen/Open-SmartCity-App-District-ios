import Foundation
import SwiftUI

struct MapSettings {
    var isScrollEnabled: Bool = true
    var isZoomEnabled: Bool = true
    var isPitchEnabled: Bool = true
    var isRotateEnabled: Bool = true
    var showsUserLocation: Bool = true
    var zoomSpace: CGFloat = 50
    var showsCompass = false
    var showsUserTrackingButton = false
}
