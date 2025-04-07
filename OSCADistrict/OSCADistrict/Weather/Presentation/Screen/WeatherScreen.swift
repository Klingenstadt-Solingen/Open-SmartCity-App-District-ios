import SwiftUI
import SDWebImageSwiftUI
import Factory

struct WeatherScreen: View {
    @InjectedObject(\.districtViewModel) var districtViewModel
    @StateObject var weatherVM = WeatherViewModel()
    
    var body: some View {
        
        let semanticsTemperature = Text("temperature", bundle: OSCADistrict.bundle)
        let semanticsChangeLocation = Text("change_location_button", bundle: OSCADistrict.bundle)
        
        
        VStack(alignment: .leading, spacing: DistrictDesign.Spacing.MEDIUM) {
            TitleView(title: "weather_title")
                .padding(.horizontal, DistrictDesign.Padding.BIGGER)
            LoadingWrapper(loadingStates: weatherVM.loadingState) {
                if let selectedWeather = weatherVM.selectedWeather {
                    HStack(spacing: DistrictDesign.Spacing.DEFAULT) {
                        Text(selectedWeather.name ?? "")
                            .font(DistrictDesign.Size.Font.SUB_TITLE)
                        Spacer()
                        Button(action: {
                            weatherVM.changeSelectedWeather(nil)
                        }) {
                            Image("ic_location", bundle: OSCADistrict.bundle)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: DistrictDesign.Size.Icon.BIG, maxHeight: DistrictDesign.Size.Icon.BIG)
                                .foregroundColor(.primary)
                                .padding(DistrictDesign.Padding.MEDIUM)
                        }.buttonStyle(GeneralButtonStyle())
                            .accessibilityLabel(semanticsChangeLocation)
                            .font(DistrictDesign.Size.Font.DEFAULT)
                    }
                    .padding(.horizontal, DistrictDesign.Padding.BIGGER)
                    ScrollView {
                        VStack(spacing: DistrictDesign.Spacing.BIG) {
                            ZStack {
                                if let image = selectedWeather.image {
                                    WebImage(url: URL(string: image)!)
                                        .resizable()
                                        .placeholder {
                                            Image("dashboard_image", bundle: OSCADistrict.bundle)
                                                .resizable()
                                                .overlay {
                                                    Rectangle().foregroundColor(.black).opacity(0.5)
                                                }
                                        }.accessibilityHidden(true)
                                       
                                }
                                if let temperature = WeatherMeasurement.getTemperature(weatherVM.selectedWeather?.getValues()) {
                                    
                                    var temp = Text("\(temperature.value, specifier: "%.1f") \(temperature.unit)")
                                    
                                    HStack(spacing: DistrictDesign.Spacing.DEFAULT) {
                                        Image("ic_thermometer", bundle: OSCADistrict.bundle)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: DistrictDesign.Size.Icon.BIGGER)
                                            .foregroundColor(.white)
                                            .accessibilityHidden(true)
                                        temp
                                            .font(.system(size: 50).bold())
                                            .foregroundColor(.white)
                                            .accessibilityLabel(semanticsTemperature)
                                            .font(DistrictDesign.Size.Font.DEFAULT)
                                            .accessibilityValue(temp)
                                    }
                                }
                            }
                            .frame(height: 150, alignment: .center)
                            .frame(maxWidth: .infinity)
                            .clipShape(DistrictDesign.ROUNDED_RECTANGLE)
                            .shadow()
                            .clipped()
                            .accessibilityElement(children: .combine)
    
                            if let measurements = weatherVM.selectedWeather?.getValues() {
                                VStack(spacing: DistrictDesign.Spacing.DEFAULT) {
                                    ForEach(0..<measurements.endIndex, id: \.self) { index in
                                        if measurements[index].name != "Temperatur" {
                                            WeatherMeasurementView(measurement: measurements[index])
                                                .shadow()
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, DistrictDesign.Padding.BIGGER)
                        .padding(.bottom, DistrictDesign.Padding.MEDIUM)
                    }
                } else {
                    WeatherSelectionScreen()
                        .environmentObject(weatherVM)
                }
            }
            .task{
                await weatherVM.getWeather()
            }.refreshable {
                await Task {
                    await weatherVM.getWeather()
                }.value
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}
