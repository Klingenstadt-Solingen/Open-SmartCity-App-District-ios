import Foundation
import ParseCore


extension PFObject: Identifiable {
    public var id: String { objectId ?? UUID().uuidString }
}
