import Foundation
import Factory

class MobilityMapViewModel: Loadable {
    @Injected(\.mobilityRepository) var mobilityRepository: MobilityRepository
    @Published var loadingState: LoadingState = .initializing
    
    @Published var mobilityTypes: [MobilityType] = []
    @Published var selectedMobilityType: MobilityType? = nil
    
    @Published var mobilityObjects: [MobilityObjectItem] = []
    @Published var selectedMobilityObject: MobilityObjectItem? = nil
    
    @Published var debounceSearchText = ""
    @Published var searchText = ""
    
    func initTypes(
        lat: Double = 51.171717999,
        lon: Double = 7.085664999,
        rangeInMeter: Double = 10000
    ) async {
        await loadingStateScope {
            let newMobilityTypes = try await mobilityRepository.getMobilityTypes()
            await MainActor.run {
                mobilityTypes = newMobilityTypes
                if let newMobilityType = newMobilityTypes.first {
                    selectedMobilityType = newMobilityType
                }
            }
        }
    }

    func getVehciles(
        typeId: String,
        lat: Double = 51.171717999,
        lon: Double = 7.085664999,
        rangeInMeter: Double = 10000
    ) async {
        await loadingStateScope {
            let newMobilityObjects = try await mobilityRepository.getAllMobilityObject(
                typeId: typeId,
                lat: lat,
                lon: lon,
                rangeInMeter: rangeInMeter,
                skip: 0,
                limit: 10000
            )
            
            await MainActor.run {
                mobilityObjects = newMobilityObjects
            }
        }
    }
}

extension Container {
    var mobilityMapViewModel: Factory<MobilityMapViewModel> {
        Factory(self) { MobilityMapViewModel() }.shared
    }
}
