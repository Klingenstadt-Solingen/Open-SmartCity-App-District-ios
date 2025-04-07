import SwiftUI
import MapKit

struct MapMarkerView<Content>: View where Content: View {
    var title: String?
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var identifier: String = ""
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        content()
    }
}

extension MapMarkerView where Content == EmptyView {
    init() {
        self.init {
            EmptyView()
        }
    }
}

#Preview {
    MapMarkerView(coordinate: CLLocationCoordinate2D(), identifier: "Test") {
        Text("test")
    }
}
