/// Defines the various states of a meeting.
enum PoliticMeetingState: String, Codable {
    /// Meeting is scheduled but not yet started.
    case scheduled = "SCHEDULED"
    
    /// Invitations have been sent for the meeting.
    case invited = "INVITED"
    
    /// Meeting has been conducted.
    case performed = "PERFORMED"
    
    /// Meeting has been cancelled.
    case cancelled = "CANCELLED"
    
    /// Meeting state is not specified or available.
    case none = "NONE"
    
    /// Unknown state of the meeting.
    case unknown = "UNKNOWN"
}
