import Foundation
import SwiftUI



struct OSCADisclosureGroupStyle: DisclosureGroupStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            withAnimation {
                if #available(iOS 16.0, *) {
                    configuration.isExpanded.toggle()
                }
            }
        }, label: {
            HStack(spacing: DistrictDesign.Spacing.DEFAULT) {
                configuration.label
                Spacer()
                
                Image("ic_right", bundle: OSCADistrict.bundle)
                    .resizable()
                    .scaledToFit()
                    .frame(width: DistrictDesign.Size.Icon.MEDIUM, height: DistrictDesign.Size.Icon.MEDIUM)
                    .foregroundColor(.accentColor)
                    .rotationEffect(.degrees(configuration.isExpanded ? 90 : 0))
            }
        }).buttonStyle(.plain)
        .contentShape(Rectangle())
        
        if configuration.isExpanded {
            configuration.content
        }
    }
}
