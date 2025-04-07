import Foundation
import ParseCore

protocol SteleDiashowObjectRepository {
    static func getDiashowObjectsByDiashowConfig(_ diashowConfig: SteleDiashowConfig) async throws -> [SteleDiashowObject];
    static func getDiashowObjectCountByDiashowConfig(_ diashowConfig: SteleDiashowConfig) async -> Int
}
