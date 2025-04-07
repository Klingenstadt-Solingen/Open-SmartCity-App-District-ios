import SwiftUI
import Factory

class BookmarkViewModel: ObservableObject {
    @Published var eventBookmarks: [String] = UserDefaults.standard.stringArray(forKey: "events_bookmarked_ids") ?? [String]()

    func toggleEventBookmark(objectId: String?) {
        if let objectId = objectId {
            if (eventBookmarks.contains(where: { bookmarkId in
                bookmarkId == objectId
            })) {
                let filteredBookmarkedIds = eventBookmarks.filter({ bookmarkId in
                    return bookmarkId != objectId
                })
                eventBookmarks = filteredBookmarkedIds
            } else {
                eventBookmarks.append(objectId)
            }
            UserDefaults.standard.setValue(eventBookmarks, forKey: "events_bookmarked_ids")
        }
    }
    
    func isEventBookmarked(objectId: String?) -> Bool {
        return eventBookmarks.contains(where: { bookmarkId in
            bookmarkId == objectId
        })
    }
}

extension Container {
    var bookmarkViewModel: Factory<BookmarkViewModel> {
        Factory(self) { BookmarkViewModel() }.singleton
    }
}
