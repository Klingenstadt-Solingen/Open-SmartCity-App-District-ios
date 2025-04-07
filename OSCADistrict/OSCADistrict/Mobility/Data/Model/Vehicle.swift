import Foundation

struct Vehicle: MobilityObject {
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
    
    var description: String?
    var color: String?
    var secondaryColor: String?
    
    var plateNumber: String?
    var batteryPercentage: Int?
    var pricingPlan: PricingPlan?
    var remainingRangeInMeter: Int?
    
    var updatedAt: Date?
}

struct PricingPlan: Equatable, Hashable, Decodable {
    var currency: String
    var description: String
    var isTaxable: Bool
    var name: String
    var price: Float
    var surgePricing: Bool?
    var url: String?
    var perKmPricing: Array<PricingModel>
    var perMinPricing: Array<PricingModel>
}

struct PricingModel: Equatable, Hashable, Decodable {
    var end: Int?
    var interval: Int?
    var rate: Int?
    var start: Int?
}
