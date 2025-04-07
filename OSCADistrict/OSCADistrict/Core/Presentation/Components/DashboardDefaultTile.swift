import SwiftUI

struct DashboardDefaultTile<Content>: View where Content: View {
    var title: LocalizedStringKey
    var image: String
    @Binding var count: Int
    
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if count > 0 {
                CounterCircle(count: count)
            }
            VStack(alignment: .center,spacing: DistrictDesign.Spacing.DEFAULT) {
                HStack(alignment: .center, spacing: DistrictDesign.Spacing.DEFAULT) {
                    Image(image, bundle: OSCADistrict.bundle)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.primary)
                        .frame(width: DistrictDesign.Size.Icon.BIGGER, height: DistrictDesign.Size.Icon.BIGGER)
                    content()
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                
                Text(title, bundle: OSCADistrict.bundle)
                    .font(DistrictDesign.Size.Font.SUB_SUB_TITLE.bold())
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .padding(.horizontal, DistrictDesign.Padding.MEDIUM)
            .padding(.top, DistrictDesign.Padding.SMALLEST)
        }
        .padding(DistrictDesign.Padding.MEDIUM)

    }
}

extension DashboardDefaultTile where Content == EmptyView {
    init(
        title: LocalizedStringKey,
        image: String,
        count: Binding<Int> = .constant(0)
    ) {
        self.init(title: title, image: image, count: count) {
            EmptyView()
        }
    }
}


extension DashboardDefaultTile where Content == EmptyView {
    init(
        title: LocalizedStringKey,
        image: String
    ) {
        self.init(title: title, image: image, count: .constant(0))
    }
}


extension DashboardDefaultTile {
    init(
        title: LocalizedStringKey,
        image: String,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.init(title: title, image: image, count: .constant(0), content: content)
    }
}


#Preview {
    DashboardDefaultTile(title: "Test", image: "Test")
}
