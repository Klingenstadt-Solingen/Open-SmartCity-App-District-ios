import Foundation

struct VehicleStation: MobilityObject {
    var id: String
    var name: String
    var information: String
    var geopoint: Coordinate
    var providerName: String?
    var iconUrl: String?
    var address: String?
    var iosDeeplink: String?
    var androidDeeplink: String?
    var webUrl: String?
    var updatedAt: Date?
    
    var shortName: String?
    var vehicles: [Vehicle]
    var parkingType: ParkingType
    var parkingSpacesAmount: Int?
    var availableVehicleAmount: Int?
}
