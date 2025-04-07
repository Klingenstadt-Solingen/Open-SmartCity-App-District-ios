import SwiftUI
import SDWebImageSwiftUI

struct PressReleaseListItemImageView: View {
    var url: String?
    
    var body: some View {
        if let imageUrl = URL(string: url ?? "") {
            WebImage(url: imageUrl)
                .resizable()
                .indicator { _, _ in
                    ProgressView()
                }
                .transition(.fade)
                .scaledToFill()
                .frame(maxWidth: 100, alignment: .center)
                .clipped()
        } else {
            Image("ic_megaphone_with_soundwave", bundle: OSCADistrict.bundle)
                .resizable()
                .padding(DistrictDesign.Padding.MEDIUM)
                .scaledToFit()
                .frame(maxWidth: 100)
                .foregroundColor(Color.primary)
        }
    }
}

