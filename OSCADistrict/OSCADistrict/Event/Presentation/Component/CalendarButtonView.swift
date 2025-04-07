import SwiftUI
import Foundation

struct CalendarButton: View {
    @EnvironmentObject var viewModel: EventDetailViewModel
    @State var isPresentingCalendarConfirm = false
    
    var body: some View {
        Button(action: { isPresentingCalendarConfirm = true } ){
            Image("ic_calendar", bundle: OSCADistrict.bundle)
                .resizable()
                .scaledToFit()
                .frame(width: DistrictDesign.Size.Icon.BIG, height: DistrictDesign.Size.Icon.BIG)
                .padding(DistrictDesign.Padding.MEDIUM)
                .foregroundColor(Color.primary)
        }.buttonStyle(AccentButtonStyle())
            .confirmationDialog(
                Text(
                    viewModel.isEventAccessGranted ? "calendar_permission_granted" : "calendar_permission_not_granted",
                    bundle: OSCADistrict.bundle
                ),
                isPresented: $isPresentingCalendarConfirm,
                titleVisibility: .visible) {
                    Button(action: {
                        Task {
                            await viewModel.addToCalendar()
                        }
                    }) {
                        Text(viewModel.isEventAccessGranted ? "add_to_calendar_button" : "open_settings_button", bundle: OSCADistrict.bundle)
                    }
                }
    }
}
