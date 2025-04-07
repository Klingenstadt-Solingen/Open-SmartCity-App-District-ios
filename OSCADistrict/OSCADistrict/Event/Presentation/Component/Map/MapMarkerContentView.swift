import SwiftUI
import SDWebImageSwiftUI
import OSCAEssentials
import ParseCore

struct MapMarkerContentView<T>: View {
    var url: String?
    var entity: T
    var title: String?
    var callback: ((T) -> Void)?
    
    var body: some View {
        Button {
            callback?(entity)
        } label: {
            VStack(alignment: .center) {
                WebImage(url: URL(string: url ?? ""))
                    .resizable()
                    .scaledToFit()
                if let title = self.title {
                    Text(title)
                        .scaledToFill()
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                }
            }
        }
    }
}

#Preview {
    MapMarkerContentView(url: "", entity: OSCAPointOfInterest(), callback: { object in
        
    })
}
