import SwiftUI

/**
 - Parameters:
 - buttonColor: Background color of the Button
 */
struct GeneralButtonStyle: ButtonStyle {
    var forgroundColor: Color = Color.black
    var buttonColor: Color = Color.white
    var selectionBrightness = -0.1
    var cornerRadius: CGFloat? = nil
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .cornerRadius(cornerRadius ?? DistrictDesign.CORNER_RADIUS)
            .background(DistrictDesign.ROUNDED_RECTANGLE
            .shadow()
            .foregroundColor(buttonColor))
            .brightness(configuration.isPressed ? selectionBrightness : 0.0)
            .foregroundColor(forgroundColor)
    }
}
