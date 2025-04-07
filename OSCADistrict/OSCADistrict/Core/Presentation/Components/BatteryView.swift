import SwiftUICore

struct BatteryView : View {
    var batteryLevel: Int = 40
    var showValue: Bool = true
    
    var color : Color {
        switch batteryLevel {
        case 0...20:
            return Color.red
        case 20...50:
            return Color.yellow
        case 50...100:
            return Color.green
        default:
            return Color.clear
        }
    }
    
    var percent: Double {
        max(0.0, min(1.0, 0.1 + (0.7 * Double(batteryLevel)/100.0)))
    }

    var body: some View {
        HStack {
            if showValue {
                Text(
                    "battery_level \(batteryLevel)",
                    bundle: OSCADistrict.bundle
                )
            }
            
            Image(systemName: "battery.100percent")
                .symbolRenderingMode(.palette)
                .foregroundStyle(LinearGradient(stops: [
                    Gradient.Stop(color: color, location: 0),
                    Gradient.Stop(color: color, location: percent),
                    Gradient.Stop(color: .clear, location: percent),
                    Gradient.Stop(color: .clear, location: 1),
                ], startPoint: .leading, endPoint: .trailing), .primary)
        }
    }
}

