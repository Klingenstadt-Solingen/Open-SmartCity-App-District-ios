import SwiftUI

/**
 - Parameters:
 - selected: Sets if the button is selected
 */
struct OSCASelectionButtonStyle: ButtonStyle {
    var selected: Bool = false
    
    func makeBody(configuration: Self.Configuration) -> some View {
        var contentView = configuration.label
            .cornerRadius(DistrictDesign.CORNER_RADIUS)
            .background(DistrictDesign.ROUNDED_RECTANGLE
            .shadow()
            .foregroundColor(selected ? .accentColor : .white))
            .brightness(configuration.isPressed ? -0.1 : 0.0)
            .foregroundColor(selected ? .primary : .black)
        if #available(iOS 16.0, *) {
            return contentView.fontWeight(selected ? .bold : .regular)
        }
        return contentView
    }
}
