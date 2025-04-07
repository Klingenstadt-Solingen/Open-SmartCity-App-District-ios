import SwiftUI

struct ProjectInfoView: View {
    var project: Project
    
    var body: some View {
        HStack(spacing: DistrictDesign.Spacing.DEFAULT) {
            ProjectStatusView(status: project.status)
            
            if let startDate = project.startDate {
                ProjectDateView(startDate: startDate, endDate: project.endDate)
            }
            Spacer()
            if #available(iOS 16.0, *) {
                if let url = project.url {
                    ShareButton(url: url)
                    .frame(alignment: .trailing)
                }
            }
        }
        .font(DistrictDesign.Size.Font.NORMAL_TEXT)
    }
}
