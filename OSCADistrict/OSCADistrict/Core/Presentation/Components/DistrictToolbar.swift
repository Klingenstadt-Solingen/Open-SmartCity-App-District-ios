import SwiftUI
import Factory

struct DistrictToolbar: View {
    @InjectedObject(\.districtViewModel) var districtViewModel
    @State private var showingPreference = false
    
    var body: some View {
        HStack {
            VStack(spacing: DistrictDesign.Spacing.DEFAULT) {
                Button(action: { showingPreference.toggle() }) {
                    let icon = Image("ic_person", bundle: OSCADistrict.bundle)
                        .resizable()
                        .frame(width: 40, height: 40)
                    
                    if #available(iOS 16.0, *) {
                        icon.popover(isPresented: $showingPreference) {
                            DistrictPreferenceScreen()
                                .frame(width: .infinity)
                                .presentationDetents(
                                    [.height(200)]
                                )
                                .presentationDragIndicator(.visible)
                        }
                    }
                }
                .accessibilityLabel(Text("settings_button", bundle: OSCADistrict.bundle)).font(DistrictDesign.Size.Font.DEFAULT)
            }
        }
    }
}

#Preview {
    DistrictToolbar()
}
