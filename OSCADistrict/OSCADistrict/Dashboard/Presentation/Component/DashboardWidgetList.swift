import SwiftUI


struct DashboardWidgetList: View {
    @State var widgets: [any DashboardWidgetWrapper] = [
        PressReleaseWidgetWrapper(),
        PointOfInterestWidgetWrapper()
    ]

    var body: some View {
        VStack(spacing: DistrictDesign.Spacing.DEFAULT) {
            ForEach(Array(widgets.enumerated()), id: \.element.id) { index, widget in
                AnyView(widget.contentView)
                    .mask(DistrictDesign.ROUNDED_RECTANGLE)
                    .background {
                        if index == 0 {
                            if #available(iOS 16.0, *) {
                                DistrictDesign.ROUNDED_RECTANGLE
                                    .fill(.shadow(.inner(color: Color(.sRGBLinear, white: 0, opacity: 0.16), radius: 3, x: -2, y: 2)))
                                    .foregroundColor(Color.white)
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    DashboardWidgetList()
}
