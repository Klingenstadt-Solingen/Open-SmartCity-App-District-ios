import SwiftUI
import Foundation

struct FavoriteButtonView: View {
    var isFavorite: Bool = false
    var iconPadding: CGFloat = DistrictDesign.Padding.MEDIUM
    var action: () -> Void = {}
    
    var body: some View {
        Button(action: action) {
            Image(
                isFavorite ? "ic_fav_enabled" : "ic_fav_disabled",
                bundle: OSCADistrict.bundle
            )
            .resizable()
            .scaledToFit()
            .frame(
                width: DistrictDesign.Size.Icon.BIG,
                height: DistrictDesign.Size.Icon.BIG
            )
            .padding(iconPadding)
            .foregroundColor(Color.primary)
        }.buttonStyle(AccentButtonStyle())
    }
}
