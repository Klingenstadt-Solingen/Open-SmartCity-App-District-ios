import SwiftUI

struct TitleView: View {
    var title: LocalizedStringKey
    
    var body: some View {
        Text(title, bundle: OSCADistrict.bundle)
            .font(DistrictDesign.Size.Font.HEADLINE)
            .padding(.vertical, DistrictDesign.Padding.MEDIUM)
    }
}
