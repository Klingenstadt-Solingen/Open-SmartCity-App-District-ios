import Foundation
import SwiftUI


struct OSCAFadeButtonToggleStyle: ToggleStyle {
    var forgroundColor: Color = Color.primary
    var selectionOpacity = 0.5
    
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            configuration.label.opacity(configuration.isOn ? 1 : selectionOpacity)
        })
    }
}
