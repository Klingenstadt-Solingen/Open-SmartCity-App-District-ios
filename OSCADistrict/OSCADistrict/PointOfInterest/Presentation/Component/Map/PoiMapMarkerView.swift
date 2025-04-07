import SwiftUI
import MapKit

struct PoiMapMarkerView<Content>: View where Content: View {
    var title: String?
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var identifier: String = ""
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        content()
    }
}

extension PoiMapMarkerView where Content == EmptyView {
    init() {
        self.init {
            EmptyView()
        }
    }
}

#Preview {
    PoiMapMarkerView(coordinate: CLLocationCoordinate2D(), identifier: "Test") {
        Text("test")
    }
}
