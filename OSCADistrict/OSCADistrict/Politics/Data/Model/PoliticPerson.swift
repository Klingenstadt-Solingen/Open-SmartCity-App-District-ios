import Foundation

/// A structure representing an individual with personal details and contact information.
struct PoliticPerson: BaseModel {
    /// The unique identifier for the person.
    let id: String
    
    /// The last name of the person.
    let lastName: String
    
    /// The first name of the person.
    let firstName: String
    
    /// A list of titles associated with the person (e.g., Dr., Prof.).
    let title: [String]
    
    /// The preferred form of address for the person.
    let formOfAddress: String?
    
    /// The gender of the person, if provided.
    let gender: String?
    
    /// A list of phone numbers associated with the person.
    let phone: [String]
    
    /// A list of email addresses associated with the person.
    let email: [String]
    
    /// A brief description of the person's life or background.
    let life: String?
    
    /// The source of information about the person's life.
    let lifeSource: String?
    
    /// A URL to more information about the person, if available.
    let webUrl: String?
    
    /// The timestamp of the last update made to the person's details.
    let updatedAt: Date
    
    /// The timestamp when the person was created in the system.
    let createdAt: Date
    
    func name() -> String {
        var nameArray = [String]()
        nameArray.append(contentsOf: title)
        let fullname = "\(firstName) \(lastName)"
        if let formOfAddress = formOfAddress {
            nameArray.append(formOfAddress)
        }
        nameArray.append(fullname)
        
        return nameArray.joined(separator: " ")
    }
}
