import SwiftUI

struct MeetingFileItemView: View {
    let downloadUrl: String
    let name: String
    let mimeType: String
    
    var body: some View {
        Link(destination: URL(string: downloadUrl)!) {
            HStack(spacing: DistrictDesign.Spacing.DEFAULT) {
                ZStack(alignment: .center) {
                    Image("ic_file", bundle: OSCADistrict.bundle)
                        .resizable()
                        .scaledToFit()
                        .frame(width: DistrictDesign.Size.Icon.BIG, height: DistrictDesign.Size.Icon.BIG)
                    Text(mimeType.uppercased().split(separator: "/").last ?? "")
                        .font(DistrictDesign.Size.Font.SMALLER_TEXT.bold())
                }.foregroundColor(Color.primary)
                Text(name)
                    .font(DistrictDesign.Size.Font.NORMAL_TEXT)
                    .lineLimit(2)
            }.multilineTextAlignment(.leading)
        }
    }
}

#Preview {
    MeetingFileItemView(downloadUrl: "", name: "Test", mimeType: "application/pdf")
}
