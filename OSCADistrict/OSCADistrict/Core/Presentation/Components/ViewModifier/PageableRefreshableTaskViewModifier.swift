import SwiftUI

struct PageableRefreshableTaskViewModifier: ViewModifier {
    let id: String
    let pageable: any Pageable
    let priority: TaskPriority = .userInitiated
    let action: @MainActor @Sendable () async -> Void
    
    func body(content: Content) -> some View {
        content.task(id: id, priority: priority) {
            await action()
            if let pageableId = pageable.pageableId {
                if (id == pageableId) {
                    return
                }
            }
            pageable.pageableId = id
            await pageable.initPageable()
        }.refreshable {
            await pageable.initPageable()
        }
    }
}

extension View {
    public func refreshableTask<ID: Equatable>(
        id: ID,
        pageable: any Pageable,
        action: @MainActor @escaping @Sendable () async -> Void = {}
    ) -> some View {
        modifier(
            PageableRefreshableTaskViewModifier(id: "\(id)", pageable: pageable, action: action)
        )
    }
}
