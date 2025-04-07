import Foundation

/// Represents a consultation paper, including its metadata and related files.
struct PoliticConsultationPaper: BaseModel {
    /// The unique identifier for the consultation paper.
    let id: String
    
    /// The name or title of the consultation paper.
    var name: String
    
    /// A reference or identifier associated with the consultation paper.
    var reference: String?
    
    /// Date which is used as the starting point for deadlines etc.
    let date: Date?
    
    /// The type of consultation paper (e.g., 'report', 'statement').
    let paperType: String?
    
    /// Indicates whether the consultation paper is authoritative.
    let authoritative: Bool
    
    /// The role or purpose of the consultation paper in its context.
    let role: String?
    
    /// The main file associated with the consultation paper, if available.
    let mainFile: PoliticFile?
    
    /// A URL to more information about the consultation paper, if available.
    let webUrl: String?
    
    /// The timestamp of the last update made to the consultation paper's details.
    let updatedAt: Date
    
    /// The timestamp when the consultation paper was created in the system.
    let createdAt: Date
}
