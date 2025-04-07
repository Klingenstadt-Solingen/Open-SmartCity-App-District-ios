import SwiftUI
import SDWebImageSwiftUI

struct EventListItem: View {
    var event: Event
    var isBookmarked: Bool
    var onBookmark: () -> ()
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack {
                VStack(alignment: .leading, spacing: DistrictDesign.Spacing.SMALL) {
                    HStack {
                        Text(event.startDate, format: .dateTime.dateOnly()).font(DistrictDesign.Size.Font.NORMAL_TEXT)
                        if let type = event.type {
                            Text(type.name).font(DistrictDesign.Size.Font.SMALL_TEXT).bold().scaledToFill()
                        }
                    }
                    HStack(spacing: DistrictDesign.Spacing.DEFAULT) {
                        if #available(iOS 16.0, *) {
                            Text(event.name).font(DistrictDesign.Size.Font.SUB_SUB_TITLE.bold()).lineLimit(3, reservesSpace: true)
                        } else {
                            Text(event.name).font(DistrictDesign.Size.Font.SUB_SUB_TITLE.bold()).lineLimit(3)
                        }
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    Text(event.category).font(DistrictDesign.Size.Font.NORMAL_TEXT)
                    EventInfoView(event: event)
                }
                ZStack(alignment: .topTrailing) {
                    Spacer().frame(minWidth: 1)
                    if let imageString = event.image, let imageUrl = URL(string: imageString) {
                        WebImage(url: imageUrl)
                            .resizable()
                            .placeholder {
                                ProgressView().progressViewStyle(OSCAProgressViewStyle())
                            }
                            .scaledToFill()
                            .frame(maxWidth: 110, maxHeight: 110)
                            .clipShape(DistrictDesign.ROUNDED_RECTANGLE)
                    } else {
                        Image("ic_confetti", bundle: OSCADistrict.bundle)
                            .resizable()
                            .scaledToFill()
                            .foregroundColor(Color.primary)
                            .frame(maxWidth: 110, maxHeight: 110)
                            .clipShape(DistrictDesign.ROUNDED_RECTANGLE)
                    }
                }.frame(maxWidth: 110, maxHeight: 110)
            }.padding(DistrictDesign.Padding.MEDIUM)
            FavoriteButtonView(
                isFavorite: isBookmarked,
                iconPadding: DistrictDesign.Padding.SMALL,
                action: onBookmark
            )
        }
    }
}
