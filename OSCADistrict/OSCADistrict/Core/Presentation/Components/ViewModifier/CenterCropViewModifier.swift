import SwiftUI


struct CenterCropViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        GeometryReader { geo in
            content
                .scaledToFill()
                .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                .clipped()
        }
    }
}

extension View {
    public func centerCrop() -> some View {
        modifier(
            CenterCropViewModifier()
        )
    }
}
