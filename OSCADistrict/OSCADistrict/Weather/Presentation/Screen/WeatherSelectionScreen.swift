import SwiftUI
import ParseCore
import Factory

struct WeatherSelectionScreen: View {
    @InjectedObject(\.districtViewModel) var districtViewModel
    @EnvironmentObject var weatherViewModel: WeatherViewModel
    @StateObject var weatherSelectionViewModel = WeatherSelectionViewModel()
    var currentLocation = CLLocationManager().location
    
    var body: some View {
        PaginationLoadingWrapper(loadingState: weatherSelectionViewModel.loadingState) {
            LazyVStack(spacing: DistrictDesign.Spacing.BIG) {
                ForEach(Array(weatherSelectionViewModel.items.enumerated()), id: \.element.id) {
                    index, weather in
                    Button(action: {selectWeather(weather)})
                    {
                        WeatherListItem(
                            weather: weather,
                            currentLocation: currentLocation,
                            selected: weatherViewModel.selectedWeatherId == weather.objectId)
                        
                    }
                    .buttonStyle(GeneralButtonStyle())
                    .task(id: index) {
                        if index == weatherSelectionViewModel.items.endIndex - 1 && weatherSelectionViewModel.items.endIndex % weatherSelectionViewModel.pageSize == 0  {
                            await weatherSelectionViewModel.loadPage()
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom, DistrictDesign.Padding.MEDIUM)
        }
        .refreshableTask (id: "\(districtViewModel.districtState)", pageable: weatherSelectionViewModel) {
            weatherSelectionViewModel.districtState = districtViewModel.districtState
        }
    }
    
    func selectWeather(_ weather: Weather) {
        weatherViewModel.changeSelectedWeather(weather)
    }
}
