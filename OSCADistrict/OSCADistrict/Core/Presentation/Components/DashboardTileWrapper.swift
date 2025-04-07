import Foundation
import SwiftUI

protocol DashboardTileWrapper: View, Identifiable {
    associatedtype Content: View
    
    var id: String { get }
    var navigationRoute: Route { get }
    @ViewBuilder var contentView: Content { get }
}

extension DashboardTileWrapper {
    var body: some View {
        GeneralNavigationLink(route: navigationRoute) {
            contentView
        }
    }
}
