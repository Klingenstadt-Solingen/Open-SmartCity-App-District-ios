/// Defines the different types of organizations.
enum PoliticOrganizationType: String, Codable {
    /// A committee or governing body.
    case committee = "COMMITTEE"
    
    /// A political party.
    case party = "PARTY"
    
    /// A faction or group within a legislative body.
    case faction = "FACTION"
    
    /// An administrative area or division.
    case administrativeArea = "ADMINISTRATIVE_AREA"
    
    /// An external committee or organization.
    case externalCommittee = "EXTERNAL_COMMITTEE"
    
    /// An institution, such as an organization or establishment.
    case institution = "INSTITUTION"
    
    /// Other types of organizations not classified above.
    case other = "OTHER"
    
    /// Unknown type of organization.
    case unknown = "UNKNOWN"
}
