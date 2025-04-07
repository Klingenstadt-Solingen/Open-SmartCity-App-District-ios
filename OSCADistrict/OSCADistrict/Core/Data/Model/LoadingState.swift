import Foundation
import SwiftUI

public enum LoadingState: Equatable {
    case initializing
    case paginating
    case loaded
    case error(errorMessage: LocalizedStringKey)
}
