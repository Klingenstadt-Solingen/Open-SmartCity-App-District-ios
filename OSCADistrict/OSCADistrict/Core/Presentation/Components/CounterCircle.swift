import SwiftUI

struct CounterCircle: View {
    var count: Int
    
    var body: some View {
        let semanticsMany = Text("many", bundle: OSCADistrict.bundle)
        let semanticsNotifications = Text("notifications", bundle: OSCADistrict.bundle)
        
        let countText = count <= 99 ? Text("\(count)") : semanticsMany
        
        ZStack {
            Circle()
                .fill(Color.accentColor)
              
            if count <= 99 {
                Text("\(count)")
                    .font(.system(size: DistrictDesign.Size.Font.DEFAULT_SIZE , weight: .bold))
                    .foregroundColor(Color.primary)
            }
        }.frame(maxWidth: 28, maxHeight: 28)
            .accessibilityLabel(countText + Text(" ") + semanticsNotifications).font(DistrictDesign.Size.Font.DEFAULT)
    
    }
}

#Preview {
    CounterCircle(count: 5)
}
