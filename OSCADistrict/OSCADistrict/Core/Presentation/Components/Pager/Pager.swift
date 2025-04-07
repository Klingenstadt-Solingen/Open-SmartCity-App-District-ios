import SwiftUI

struct Pager<Content, Data: Hashable>: View where Content: View {
    @Binding var selectedPage: Int

    var data: [Data]
    @ViewBuilder var content: (Data) -> Content

    init(
        data: [Data],
        selectedPage: Binding<Int> = .constant(0),
        @ViewBuilder content: @escaping (Data) -> Content
    ) {
        self.data = data
        self._selectedPage = selectedPage
        self.content = content
    }

    var body: some View {
        let semanticsPager = Text("page", bundle: OSCADistrict.bundle) + Text(": ")
        
        VStack(spacing: DistrictDesign.Spacing.SMALL) {
            // If you are looking for the undetectable area that accessibility tools detect, it seems to be the TabView itself
            TabView(selection: $selectedPage) {
                ForEach(Array(data.enumerated()), id: \.element) { index, d in
                    content(d).tag(index)
                }
            }.animation(.easeInOut, value: selectedPage)
            .tabViewStyle(.page(indexDisplayMode: .never))
    
            if data.count > 1 {
                HStack(alignment: .bottom, spacing: DistrictDesign.Spacing.SMALL) {
                    ForEach(data.startIndex..<data.endIndex, id: \.self) { index in
                        
                        var isSelected = selectedPage == index
                        
                        PagerButton(
                            selected: isSelected,
                            action: { selectedPage = index }
                        )
                        .accessibilityLabel(semanticsPager + Text("\(index + 1)")).font(DistrictDesign.Size.Font.DEFAULT)
                        .accessibilityAddTraits(isSelected ? .isSelected : [])
                    }
                }.animation(.linear, value: selectedPage)
            }
        }
    }
}

#Preview {
    Pager(data: ["Test", "Test", "Test"]) { t in
        Text(t)
    }
}
