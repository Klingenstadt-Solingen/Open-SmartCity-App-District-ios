import Foundation
import Papyrus

protocol BaseModel: Codable, Hashable, Identifiable {
    /// Die eindeutige ID des Objekts.
    var id: String { get }
    
    /// Die URL, die auf das Web-Objekt verweist, falls vorhanden.
    var webUrl: String? { get }
    
    /// Der Zeitstempel, wann das Objekt zuletzt aktualisiert wurde.
    var updatedAt: Date { get }
    
    /// Der Zeitstempel, wann das Objekt erstellt wurde.
    var createdAt: Date { get }
}


