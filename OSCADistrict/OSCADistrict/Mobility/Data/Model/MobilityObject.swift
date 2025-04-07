import Foundation


protocol MobilityObject: Identifiable, Equatable, Hashable, Decodable {
    /// Die eindeutige ID des Objekts.
    var id: String { get set }
    var name: String { get set }
    var information: String { get set }
    var geopoint: Coordinate { get set }
    var providerName: String? { get set }
    var iconUrl: String? { get set }
    var address: String? { get set }
    var iosDeeplink: String? { get set }
    var androidDeeplink: String? { get set }
    var webUrl: String? { get set }
    var updatedAt: Date? { get set }
}

struct Coordinate: Equatable, Hashable, Decodable  {
    var x: Double
    var y: Double
}

enum MobilityObjectItemType: String, Decodable {
    case VehicleStation
    case Vehicle
}

enum MobilityObjectItem: Decodable, Equatable, Hashable {
    case vehicleStation(VehicleStation)
    case vehicle(Vehicle)
    
    enum CodingKeys: CodingKey {
        case type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(MobilityObjectItemType.self, forKey: .type)
        let singleContainer = try decoder.singleValueContainer()
        
        switch type {
        case .VehicleStation:
            self = .vehicleStation(try singleContainer.decode(VehicleStation.self))
        case .Vehicle:
            self = .vehicle(try singleContainer.decode(Vehicle.self))
        }
    }
}
