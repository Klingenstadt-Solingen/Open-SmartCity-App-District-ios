import Foundation
import SwiftUI


/**
 - Parameters:
 - buttonColor: Background color of the Button
 */
struct OSCAImageButtonStyle: ButtonStyle {
    var forgroundColor: Color = Color.primary
    var buttonColor: Color = Color.accentColor
    var selectionOpacity = 0.5
    var cornerRadius: CGFloat? = nil
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .cornerRadius(cornerRadius ?? DistrictDesign.CORNER_RADIUS)
            .background(Circle()
                .shadow()
                .foregroundColor(buttonColor))
            .opacity(configuration.isPressed ? selectionOpacity : 1)
            .foregroundColor(forgroundColor)
    }
}
