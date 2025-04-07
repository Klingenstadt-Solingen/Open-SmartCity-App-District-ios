//

import SwiftUI

struct PagerButton: View {
    var selected: Bool = false
    
    var action: () -> Void = {}
    
    var body: some View {
        Button(action: action) {
            if selected {
                Rectangle()
                    .fill(Color.accentColor)
                    .frame(height: 11)
            } else {
                Rectangle()
                    .fill(Color("DisabledColor", bundle: OSCADistrict.bundle))
                    .frame(height: DistrictDesign.Size.Icon.SMALL)
            }
        }.disabled(selected)
    }
}

#Preview {
    PagerButton()
}
