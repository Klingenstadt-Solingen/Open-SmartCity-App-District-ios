import SwiftUI
import Factory

struct EventDetailButtonBarView: View {
    @InjectedObject(\.bookmarkViewModel) var bookmarkViewModel
    @EnvironmentObject var viewModel: EventDetailViewModel
    
    var body: some View {
        HStack() {
            Spacer()
            VStack {
                FavoriteButtonView(
                    isFavorite: bookmarkViewModel
                        .isEventBookmarked(objectId: viewModel.event.objectId),
                    action: {
                        bookmarkViewModel.toggleEventBookmark(objectId: viewModel.event.objectId)
                    }
                )
                Text("bookmark_button", bundle: OSCADistrict.bundle)
                    .font(DistrictDesign.Size.Font.NORMAL_TEXT)
                    .lineLimit(1)
            }.accessibilityElement(children: .combine)
            Spacer()
            if #available(iOS 16.0, *), let url = viewModel.event.url {
                VStack {
                    ShareLink(item: url) {
                        Image("ic_share", bundle: OSCADistrict.bundle)
                            .resizable()
                            .scaledToFit()
                            .frame(
                                width: DistrictDesign.Size.Icon.BIG,
                                height: DistrictDesign.Size.Icon.BIG
                            )
                            .padding(DistrictDesign.Padding.MEDIUM)
                            .foregroundColor(Color.primary)
                    }.buttonStyle(AccentButtonStyle())
                    Text("share_button", bundle: OSCADistrict.bundle)
                        .font(DistrictDesign.Size.Font.NORMAL_TEXT)
                        .lineLimit(1)
                }.accessibilityElement(children: .combine)
                Spacer()
            }
            VStack {
                CalendarButton()
                Text("calendar_button", bundle: OSCADistrict.bundle)
                    .font(DistrictDesign.Size.Font.NORMAL_TEXT)
                    .lineLimit(1)
            }.accessibilityElement(children: .combine)
            Spacer()
        }
    }
}
