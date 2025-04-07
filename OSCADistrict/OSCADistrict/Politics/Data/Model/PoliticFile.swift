import Foundation

/// Represents a file with its metadata and access information.
struct PoliticFile: BaseModel {
    /// The unique identifier for the file.
    let id: String
    
    /// The MIME type of the file, indicating the format (e.g., 'image/png').
    let mimeType: String?
    
    /// A URL to access the file directly.
    let accessUrl: String
    
    /// A URL for downloading the file, if available.
    var downloadUrl: String?
    
    let name: String?
    let fileName: String?
    let text: String?
    let date: Date?
    let size: Int?
    let sha512Checksum: String?
    
    /// A URL to more information about the file, if available.
    let webUrl: String?
    
    /// The timestamp of the last update made to the file's details.
    let updatedAt: Date
    
    /// The timestamp when the file was created in the system.
    let createdAt: Date
}
