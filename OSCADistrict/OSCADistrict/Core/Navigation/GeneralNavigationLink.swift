import Foundation
import SwiftUI


struct GeneralNavigationLink<Content> : View where Content : View {
    var route: Route
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationLink(value: route) {
                content()
            }
        }
    }
}
