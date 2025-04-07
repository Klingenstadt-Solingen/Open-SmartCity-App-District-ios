import Foundation
import SwiftUI
import CoreLocation

class DistrictDiashowViewModel: Loadable {
    @Published var loadingState: LoadingState = .initializing
    @Published var diashowObjects: [SteleDiashowObject] = []
    @Published var selectedPage = 0
    private var timer: Timer!
    
    func start(_ interval: Double) {
        self.timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            self.timer?.invalidate()
            let count = self.diashowObjects.count
            if count > 0 {
                self.selectedPage = (self.selectedPage + 1) % count
            }
        }
    }
    
    func initFetch(diashowConfig: SteleDiashowConfig?) async {
        if let diashowConfig = diashowConfig {
            await loadingStateScope {
                diashowObjects.removeAll()
                let newObjects = try await SteleDiashowObjectRepositoryImpl.getDiashowObjectsByDiashowConfig(diashowConfig)
                await MainActor.run {
                    diashowObjects = newObjects
                }
            }
        } else {
            await updateLoadingState(.error(errorMessage: "no_result"))
            diashowObjects.removeAll()
        }
    }
    
    func setDistrictlessState() async {
        await updateLoadingState(.initializing)
        diashowObjects.removeAll()
        await updateLoadingState(.error(errorMessage: "no_district_selected"))
    }
}
