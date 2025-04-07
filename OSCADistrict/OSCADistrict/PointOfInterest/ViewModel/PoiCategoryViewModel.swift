import SwiftUI

class PoiCategoryViewModel: Loadable {
    @Published var loadingState: LoadingState = .initializing
    @Published var categories: [PoiCategory] = []
    @Published var selectedCategories: Set<String> = []


    func initCategories(categoryId: String?) async {
        await loadingStateScope {
            categories = try await PoiCategoryRepositoryImpl.getPoiCategories()
            
            if categoryId == nil {
                selectedCategories = Set(categories.map({ category in
                    category.sourceId
                }))
            } else {
                selectedCategories = Set(arrayLiteral: categoryId!)
            }
        }
    }

    func requestCategories() async {
        await loadingStateScope {
            categories = try await PoiCategoryRepositoryImpl.getPoiCategories()
        }
    }

    func getImageUrl(poiCategory: String) -> URL? {
        let category = categories.first(where: { category in
            return category.sourceId == poiCategory
        })
        return category?.getImageUrl()
    }

    func getIconImageUrl(poiCategory: String) -> URL? {
        let category = categories.first(where: { category in
            return category.sourceId == poiCategory
        })
        return category?.getIconImageUrl()
    }

    func getCategory(sourceId : String) -> PoiCategory?  {
        for cat in categories {
            if (cat.sourceId.lowercased() == sourceId.lowercased()) {
                return cat;
            }
        }

        return nil;
    }

    func select(categoryId : String, selected : Bool) {
        if (selected) {
            selectedCategories.insert(categoryId)
        } else {
            selectedCategories.remove(categoryId)
        }
    }
}
