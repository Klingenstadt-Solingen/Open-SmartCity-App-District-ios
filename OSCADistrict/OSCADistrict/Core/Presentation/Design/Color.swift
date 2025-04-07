import Foundation
import SwiftUI


public extension Color {
    static let primary = Color("PrimaryColor", bundle: OSCADistrict.bundle)
    // normaly this can be set in the build settings
    static let accentColor = Color("AccentColor", bundle: OSCADistrict.bundle)
}
