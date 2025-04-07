import SwiftUI
import SDWebImageSwiftUI

struct ProjectGridItem: View {
    var project: Project
    
    var body: some View {
        let semanticsStatus = Text("status", bundle: OSCADistrict.bundle) + Text(": ")
        var status = Text(ProjectStatus.titleOf(status: project.status), bundle: OSCADistrict.bundle)
        GeometryReader { geo in
            VStack(alignment: .leading, spacing: 0) {
                    WebImage(url: URL(string: project.image))
                        .resizable()
                        .indicator { _, _ in
                            ProgressView()
                        }
                        .centerCrop()
                        .frame(width: geo.size.width, height: geo.size.height / 2)
                        .transition(.fade)
                VStack(alignment: .leading, spacing: 0) {
                    if #available(iOS 16.0, *) {
                        Text(project.name)
                            .lineLimit(3, reservesSpace: true)
                            .foregroundColor(.white)
                            .font(DistrictDesign.Size.Font.NORMAL_TEXT.bold())
                            .padding(.top, DistrictDesign.Padding.SMALL)
                    } else {
                        Text(project.name)
                            .lineLimit(3)
                            .foregroundColor(.white)
                            .font(DistrictDesign.Size.Font.NORMAL_TEXT.bold())
                            .padding(.top, DistrictDesign.Padding.SMALL)
                    }
                    // Force VStack to be full width and only take 1 height if there is no space
                    Spacer().frame(maxWidth: .infinity, minHeight: 1)
                    status
                        .foregroundColor(.white)
                        .font(DistrictDesign.Size.Font.SMALLER_TEXT.bold())
                        .accessibilityLabel(semanticsStatus + status).font(DistrictDesign.Size.Font.DEFAULT)
                }
                .padding(.horizontal, DistrictDesign.Padding.MEDIUM)
                .padding(.bottom, DistrictDesign.Padding.MEDIUM)
                .frame(width: geo.size.width, height: geo.size.height / 2)
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

