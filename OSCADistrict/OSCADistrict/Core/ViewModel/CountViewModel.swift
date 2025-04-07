import SwiftUI

class CountViewModel: ObservableObject {
    @Published var count = 0
    let defaultsKey: String
    
    init(defaultsKey: String) {
        self.defaultsKey = defaultsKey
    }
    
    func updateDate(districtState: DistrictState) {
        if case .nearby(_, let distance) = districtState {
            if Double(distance) == OSCADistrictSettings.shared.maxDistanceRange {
                UserDefaults.standard.set(Date.now, forKey: resolveKey(districtState: .all))
            }
        } else {
            UserDefaults.standard.set(Date.now, forKey: resolveKey(districtState: districtState))
        }
    }
    
    func getCount(districtState: DistrictState) async {
        var state = districtState
        if case .nearby(_, let distance) = districtState {
            if Double(distance) == OSCADistrictSettings.shared.maxDistanceRange {
                state = .all
            } else {
                count = .zero
                return
            }
        }
        let lastWatched = UserDefaults.standard.object(forKey: resolveKey(districtState: state)) as? Date
        if let lastWatched = lastWatched {
            self.count = await fetchCount(lastWatched: lastWatched, districtState: state)
        } else {
            self.count = .zero
        }
        
        if lastWatched == nil {
            updateDate(districtState: state)
        }
    }
    
    private func resolveKey(districtState: DistrictState) -> String{
        return "\(defaultsKey)(\(districtState.description))"
    }
    
    func fetchCount(lastWatched: Date, districtState: DistrictState) async -> Int {
        return 0
    }
}
