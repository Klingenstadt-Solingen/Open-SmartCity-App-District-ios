import SwiftUI
import Factory

struct DistrictPreferenceScreen: View {
    @InjectedObject(\.districtViewModel) var districtViewModel
    @StateObject var viewModel = DistrictPreferenceViewModel()

    var body: some View {
        let districtMode = Binding<DistrictMode>(
            get: { return self.districtViewModel.districtMode },
            set: { districtViewModel.updateDistrictMode($0) }
        )


        LoadingWrapper(loadingStates: viewModel.loadingState) {
            VStack(spacing: DistrictDesign.Spacing.BIG) {

                Picker("Mode", selection: districtMode) {
                    Text("district_mode_all", bundle: OSCADistrict.bundle).font(DistrictDesign.Size.Font.DEFAULT).tag(DistrictMode.all)
                    Text("district_mode_district", bundle: OSCADistrict.bundle).font(DistrictDesign.Size.Font.DEFAULT).tag(DistrictMode.district)
                    Text("district_mode_nearby", bundle: OSCADistrict.bundle).font(DistrictDesign.Size.Font.DEFAULT).tag(DistrictMode.nearby)
                }.pickerStyle(.segmented)

                switch (districtMode.wrappedValue) {
                    case DistrictMode.all:
                        EmptyView()
                    case DistrictMode.district: DistrictDropDown(districtViewModel: districtViewModel, viewModel: viewModel);
                    case DistrictMode.nearby:

                        MaxDistanceSlider(
                            selectedDistance: $districtViewModel.selectedDistance,
                            bounds: OSCADistrictSettings.shared.minDistanceRange...OSCADistrictSettings.shared.maxDistanceRange
                        )
                        .task(id: districtViewModel.selectedDistance, nanoseconds: 300000000)
                        {
                            districtViewModel.updateDistrictMode(DistrictMode.nearby, districtViewModel.selectedDistance)
                        };
                }
            }.padding(DistrictDesign.Padding.BIGGER)
                .frame(maxHeight: .infinity, alignment: .top)
        }.task {
            await viewModel.getDistricts()
        }.navigationTitle("preferences")
        .navigationBarTitleDisplayMode(.inline)
    }
}


private struct MaxDistanceSlider : View {
    var selectedDistance : Binding<Double>
    var bounds : ClosedRange<Double>

    var body: some View {
        var value = selectedDistance.wrappedValue;
        var label = Text("\(value == OSCADistrictSettings.shared.maxDistanceRange ? "∞" : Int(value).description) km")

        HStack {
            Slider(
                value: selectedDistance,
                in: bounds,
                label: { label }
            )

            label.frame(width: DistrictDesign.Size.Icon.HUGE)
        }

    }
}


private struct DistrictDropDown : View {
    var districtViewModel: DistrictViewModel
    @StateObject var viewModel : DistrictPreferenceViewModel


    var body: some View {

        let selectedDistrictId = Binding<String>(
            get: { return self.districtViewModel.selectedDistrict.id },
            set: { value in
                if let district = viewModel.districts.first(where: { d in d.id == value }) {
                    districtViewModel.setSelectedDistrict(district)
                }
            }
        )

        Picker(String(localized: "district", bundle: OSCADistrict.bundle), selection: selectedDistrictId) {
            ForEach(viewModel.districts) { district in
                Text(district.name).font(DistrictDesign.Size.Font.DEFAULT).tag(district.id as String?)
            }
        }.disabled(districtViewModel.districtMode != DistrictMode.district)
            .foregroundColor(Color.black)
    }
}

#Preview {
    DistrictPreferenceScreen()
}
