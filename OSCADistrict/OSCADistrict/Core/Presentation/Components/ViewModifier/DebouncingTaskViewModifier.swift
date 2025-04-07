import SwiftUI

struct DebouncingTaskViewModifier<ID: Equatable>: ViewModifier {
    let id: ID
    let priority: TaskPriority
    let nanoseconds: UInt64
    let firstInstant: Bool
    let action: @Sendable () async -> Void
    
    @State private var firstExecuted = false
    
    init(
        id: ID,
        priority: TaskPriority = .userInitiated,
        nanoseconds: UInt64,
        firstInstant: Bool = true,
        action: @escaping @Sendable () async -> Void
    ) {
        self.id = id
        self.priority = priority
        self.nanoseconds = nanoseconds
        self.firstInstant = firstInstant
        self.action = action
    }
    
    func body(content: Content) -> some View {
        content.task(id: id, priority: priority) {
            do {
                if !firstInstant || firstExecuted {
                    try await Task.sleep(nanoseconds: nanoseconds)
                }
                await action()
                firstExecuted = true
            } catch {}
        }
    }
}

extension View {
    public func task<ID: Equatable>(
        id: ID,
        priority: TaskPriority = .userInitiated,
        nanoseconds: UInt64,
        firstInstant: Bool = true,
        action: @MainActor @escaping @Sendable () async -> Void
    ) -> some View {
        modifier(
            DebouncingTaskViewModifier(
                id: id,
                priority: priority,
                nanoseconds: nanoseconds,
                firstInstant: firstInstant,
                action: action
            )
        )
    }
}
