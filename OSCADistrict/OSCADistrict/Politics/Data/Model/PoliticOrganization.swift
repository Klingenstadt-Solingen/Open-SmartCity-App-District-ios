import Foundation
import Papyrus

/// A structure representing a political organization.
struct PoliticOrganization: BaseModel {
    /// The unique identifier of the organization.
    let id: String
    
    /// The full name of the organization.
    let name: String
    
    /// The short name or abbreviation of the organization, if applicable.
    let shortName: String?
    
    /// The date when the organization was established.
    let startDate: Date?
    
    /// The date when the organization ceased operations, if applicable.
    let endDate: Date?
    
    /// The total number of members in the organization.
    let memberCount: Int
    
    /// The number of voting members within the organization.
    var votingMemberCount: Int
    
    /// The most recent mayor associated with the organization, if applicable.
    let newestMayor: PoliticMembership?
    
    /// The location associated with the organization.
    let location: PoliticLocation?
    
    /// The type of the organization.
    let organizationType: PoliticOrganizationType
    
    /// The ID of the parent organization, if this is a sub-organization.
    let subOrganizationOf: String?
    
    /// The classification of the organization, if applicable.
    let classification: String?
    
    /// The official website of the organization, if available.
    let website: String?
    
    /// The URL of the organization for web access.
    let webUrl: String?
    
    /// The timestamp of the last update of the organization details.
    let updatedAt: Date
    
    /// The timestamp when the organization was created in the system.
    let createdAt: Date
}
