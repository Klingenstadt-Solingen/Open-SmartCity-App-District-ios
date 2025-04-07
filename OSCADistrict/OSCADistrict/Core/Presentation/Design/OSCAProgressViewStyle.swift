import Foundation
import SwiftUI


struct OSCAProgressViewStyle: ProgressViewStyle {
    var strokeColor = Color.accentColor
    var strokeWidth = 8.0
    @State private var rotation = 0.0

    
    func makeBody(configuration: Configuration) -> some View {
        if let fractionCompleted = configuration.fractionCompleted, fractionCompleted != 0.0 {
           createCircle(fractionCompleted: fractionCompleted)
                .rotationEffect(.degrees(-90))
                .animation(.linear(duration: 2), value: fractionCompleted)
        } else {
            createCircle(fractionCompleted: 0.30)
            .rotationEffect(.degrees(rotation))
            .onAppear {
                withAnimation(.spring().speed(1)
                    .repeatForever(autoreverses: false)) {
                        rotation = 360.0
                }
            }
        }
    }
    
    
    private func createCircle(fractionCompleted: Double) -> some View {
        Circle()
            .trim(from: 0, to: fractionCompleted)
            .stroke(strokeColor, style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round))
            .padding(strokeWidth / 2)
            .frame(width: DistrictDesign.Size.Icon.BIGGER, height: DistrictDesign.Size.Icon.BIGGER)
    }
}
