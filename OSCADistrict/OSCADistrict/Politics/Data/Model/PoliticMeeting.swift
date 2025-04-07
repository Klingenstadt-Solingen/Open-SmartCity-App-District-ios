import Foundation

/// A structure representing a meeting with its details.
struct PoliticMeeting: BaseModel {
    /// The unique identifier of the meeting.
    let id: String
    
    /// The name or title of the meeting.
    let name: String
    
    /// The start date and time of the meeting.
    let startDateTime: Date?
    
    /// The end date and time of the meeting.
    let endDateTime: Date?
    
    /// The location where the meeting takes place.
    let location: PoliticLocation?
    
    /// The current state of the meeting.
    let meetingState: PoliticMeetingState
    
    /// The file associated with the meeting invitation.
    let invitationFile: PoliticFile?
    
    /// The file containing the results protocol of the meeting.
    let resultsProtocolFile: PoliticFile?
    
    /// The file containing the verbatim protocol of the meeting.
    let verbatimProtocolFile: PoliticFile?
        
    /// The website URL for the meeting, if available.
    let webUrl: String?
    
    /// The timestamp of the last update of the meeting details.
    let updatedAt: Date
    
    /// The timestamp when the meeting was created in the system.
    let createdAt: Date
}
