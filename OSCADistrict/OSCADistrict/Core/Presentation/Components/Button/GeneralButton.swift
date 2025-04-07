
import SwiftUI

struct GeneralButton<Content : View>: View {
    
    var action : () -> Void
    var label : () -> Content
    
    var body: some View {
        Button(
            action: action,
            label: label
        )
        .buttonStyle(OSCASelectionButtonStyle(selected: false))
        
    }
}

