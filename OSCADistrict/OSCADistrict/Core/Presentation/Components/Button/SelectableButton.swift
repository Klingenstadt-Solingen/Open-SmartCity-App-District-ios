
import SwiftUI

struct SelectableButton<Content : View>: View {
    var action : () -> Void
    var selected : Bool
    var disableable: Bool = true
    var label : () -> Content

    var body: some View {
        Button(
            action: action,
            label: label
        )
        .buttonStyle(OSCASelectionButtonStyle(selected: selected))
        .disabled(disableable ? selected : false)
        .accessibilityAddTraits(selected ? .isSelected : [])
    }
}

struct SelectableTextButton: View {
    var action : () -> Void
    var label : LocalizedStringKey
    var selected : Bool

    var body: some View {
        SelectableButton(action: action, selected: selected) {
            Text(label, bundle: OSCADistrict.bundle)
                .font(DistrictDesign.Size.Font.SUB_SUB_TITLE)
                .frame(height: 45)
                .padding(.horizontal, DistrictDesign.Padding.MEDIUM)
                .lineLimit(1)
        }
    }
}
