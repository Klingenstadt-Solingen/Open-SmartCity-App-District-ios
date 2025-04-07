import Foundation

/// A structure representing an agenda item on a meeting.
struct PoliticAgendaItem: BaseModel {
    /// The unique identifier of the agenda item.
    let id: String
    
    /// The name or title of the agenda item.
    let name: String
    
    /// The order of the agenda item in the meeting.
    let order: Int
    
    /// The number assigned to the agenda item, if applicable.
    let number: String?
    
    /// The start date and time of the agenda item.
    let startDateTime: Date?
    
    /// The end date and time of the agenda item.
    let endDateTime: Date?
    
    /// Indicates if the agenda item is public.
    let `public`: Bool
    
    /// The outcome or result of the agenda item discussion.
    let result: String?
    
    /// The text of any resolution passed for the agenda item.
    let resolutionText: String?
    
    /// The file associated with the resolution of the agenda item.
    let resolutionFile: PoliticFile?
    
    /// The consultation paper for the agenda item, if applicable.
    let consultationPaper: PoliticConsultationPaper?
    
    /// The Auxiliary Files for the agenda item, if applicable.
    let auxiliaryFiles: [AuxiliaryFile] = []
    
    /// The website URL for the agenda item, if available.
    let webUrl: String?
    
    /// The timestamp of the last update of the agenda item.
    let updatedAt: Date
    
    /// The timestamp when the agenda item was created in the system.
    let createdAt: Date
}
