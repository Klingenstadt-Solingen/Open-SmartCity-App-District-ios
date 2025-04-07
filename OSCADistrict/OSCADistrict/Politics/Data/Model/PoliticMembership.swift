import Foundation

/// A structure representing a membership within an organization.
struct PoliticMembership: BaseModel {
    /// The unique identifier of the membership.
    let id: String
    
    /// The role of the member within the organization, if applicable.
    let role: String?
    
    /// Indicates if the member is a mayor.
    let mayor: Bool
    
    /// Indicates if the member has voting rights.
    let votingRight: Bool
    
    /// The date when the membership started.
    let startDate: Date?
    
    /// The date when the membership ended, if applicable.
    let endDate: Date?
    
    /// The person associated with the membership.
    let person: PoliticPerson
    
    /// The organization or entity on behalf of which the member acts, if applicable.
    let onBehalfOf: String?
    
    /// The organization or entity on behalf of which the member acts, if applicable.
    let organizationId: String?
    
    /// The organization or entity on behalf of which the member acts, if applicable.
    let organizationName: String?
    
    /// The website URL for the membership, if available.
    let webUrl: String?
    
    /// The timestamp of the last update of the membership details.
    let updatedAt: Date
    
    /// The timestamp when the membership was created in the system.
    let createdAt: Date
}
