import SwiftUI

struct AccentButtonStyle: ButtonStyle {
    var forgroundColor = Color.primary
    var selectionOpacity = 0.5
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .cornerRadius(DistrictDesign.CORNER_RADIUS)
            .background(
                DistrictDesign.ROUNDED_RECTANGLE
                .shadow()
                .foregroundColor(Color.accentColor))
            .opacity(configuration.isPressed ? selectionOpacity : 1)
            .foregroundColor(forgroundColor)
    }
}
