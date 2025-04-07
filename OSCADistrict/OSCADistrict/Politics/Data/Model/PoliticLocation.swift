import Foundation

/// A structure representing a physical location.
struct PoliticLocation: BaseModel {
    /// The unique identifier of the location.
    let id: String
    
    /// The room number or name within the location, if applicable.
    let room: String?
    
    /// Additional details or notes about the location.
    let description: String?
    
    /// The full street address of the location.
    let streetAddress: String?
    
    /// The postal or ZIP code of the location.
    let postalCode: String?
    
    /// The city or locality where the location is situated.
    let locality: String?
    
    /// The sub-locality or district within the city, if applicable.
    let subLocality: String?
    
    /// The website URL related to the location, if available.
    let webUrl: String?
    
    /// The timestamp of the last update of the location details.
    let updatedAt: Date
    
    /// The timestamp when the location was created in the system.
    let createdAt: Date
}
