import SwiftUI

struct ProjektStatusTabsView: View {
    @EnvironmentObject var viewModel: ProjectGridViewModel
    
    var body: some View {
        HStack(spacing: DistrictDesign.Spacing.DEFAULT) {
            SelectableTextButton(
                action: {
                    viewModel.projectStatus = nil
                },
                label: ProjectStatus.titleOf(status: nil),
                selected: viewModel.projectStatus == nil
            )
            
            ForEach(viewModel.status, id: \.self) { status in
                SelectableTextButton(
                    action: {
                        viewModel.projectStatus = status
                    }, 
                    label: ProjectStatus.titleOf(status: status),
                    selected: viewModel.projectStatus?.objectId == status.objectId
                )
            }
        }
    }
}

#Preview {
    ProjektStatusTabsView()
}
