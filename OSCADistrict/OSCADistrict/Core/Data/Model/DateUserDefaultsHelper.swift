import Foundation

class DateUserDefaultsHelper {
    static func getMostRecentDate(districtState : DistrictState, resolveDistrict: (_ state : DistrictState) -> String) -> Date? {
        return UserDefaults.standard.object(forKey: resolveDistrict(districtState)) as? Date
    }
}
