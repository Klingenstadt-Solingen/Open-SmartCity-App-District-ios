import Foundation
import SwiftUI
import CoreLocation
import Factory

class DistrictViewModel: Loadable {
    static var shared = DistrictViewModel()
    var initialized = false
    @Published var loadingState: LoadingState = .initializing
    @Published var districtState: DistrictState = .all
    @Published var diashowCount: Int = 0
    @AppStorage("maxDistance") var selectedDistance : Double = OSCADistrictSettings.shared.minDistanceRange
    
    @AppStorage("selectedDistrict") private var selectedDistrictId: String?
    @AppStorage("districtMode") public private(set) var districtMode: DistrictMode = .all
    
    public private(set) var selectedDistrict: District = District()
    
    func setSelectedDistrict(_ district: District) {
        guard let objectId = district.objectId else { return }
        selectedDistrictId = objectId
        selectedDistrict = district
        guard case .district = districtState else { return }
        districtState = .district(district)
    }
    
    func initFetch() async {
        if (initialized) {
            return
        }
        initialized = true
        await loadingStateScope {
            if let selectedDistrictId = selectedDistrictId {
                let district = try await DistrictRepositoryImpl.getDistrictById(selectedDistrictId)
                await MainActor.run {
                    selectedDistrict = district
                }
            } else {
                let district = try await DistrictRepositoryImpl.getFirstDistrict()
                await MainActor.run {
                    selectedDistrictId = district.id
                    selectedDistrict = district
                }
            }
            await MainActor.run {
                updateDistrictMode(districtMode, selectedDistance)
            }
        }
    }
    
    func updateDistrictMode(_ districtMode: DistrictMode, _ maxDistance : Double = OSCADistrictSettings.shared.minDistanceRange) {
        self.districtMode = districtMode
        switch districtMode {
        case .district:
            districtState = .district(selectedDistrict)
        case .all:
            districtState = .all
        case .nearby:
            let loc = CLLocationManager().location;
            
            districtState = .nearby(loc != nil ? loc! : CLLocation(),  Float(maxDistance))
        }
    }
    
    func fetchDiashowCount() async {
        await MainActor.run {
            diashowCount = 0
        }
        if case .district(let district) = districtState, let diashowConfig = district.diashowConfig {
            let count = await SteleDiashowObjectRepositoryImpl.getDiashowObjectCountByDiashowConfig(diashowConfig)
            await MainActor.run {
                diashowCount = count
            }
        }
    }
}

extension Container {
    var districtViewModel: Factory<DistrictViewModel> {
        Factory(self) { DistrictViewModel() }.singleton
    }
}
