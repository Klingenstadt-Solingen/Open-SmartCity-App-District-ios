//

import Foundation
import SwiftUI


public struct DistrictDesign {
    struct Padding {
        static let SMALLEST: CGFloat = 2
        static let DEFAULT: CGFloat = 8
        static let SMALL: CGFloat = 5
        static let MEDIUM: CGFloat  = 10
        static let BIG: CGFloat = 15
        static let BIGGER: CGFloat = 18
        static let HUGE: CGFloat  = 20
    }

    
    static func GRID_CELLS_ADAPTIVE(spacing: CGFloat = Spacing.BIG) -> GridItem {
        return GridItem(.adaptive(minimum: 150), spacing: spacing)
    }
    struct Spacing {
        static let DEFAULT: CGFloat = 8
        static let SMALL: CGFloat = 2
        static let MEDIUM: CGFloat = 5
        static let BIG: CGFloat  = 10
    }
    
    static let CORNER_RADIUS: CGFloat = 10
    static let ROUNDED_RECTANGLE: RoundedRectangle  = RoundedRectangle(cornerRadius: CORNER_RADIUS)
    
    static let ELEVATION_MEDIUM: CGFloat  = 8
    
    struct Size{
        struct Icon{
            static let SMALL: CGFloat  = 10
            static let MEDIUM : CGFloat = 15
            static let BIG: CGFloat  = 25
            static let BIGGER: CGFloat  = 50
            static let HUGE: CGFloat = 60
        }
        
        struct Font{
            static let HEADLINE_SIZE: CGFloat = 25
            static let HEADLINE: SwiftUI.Font = SwiftUI.Font.system(size: HEADLINE_SIZE).bold()
            static let SUB_TITLE_SIZE: CGFloat = 22
            static let SUB_TITLE: SwiftUI.Font = SwiftUI.Font.system(size: SUB_TITLE_SIZE)
            static func SUB_TITLE(_ bold: Bool) -> SwiftUI.Font {
                return SwiftUI.Font.system(size: SUB_TITLE_SIZE,weight: bold ? .bold : .light)
            }
            
            static let SUB_SUB_TITLE_SIZE: CGFloat = 18
            static let SUB_SUB_TITLE: SwiftUI.Font = SwiftUI.Font.system(size: SUB_SUB_TITLE_SIZE)
            static func SUB_SUB_TITLE(_ bold: Bool) -> SwiftUI.Font {
                return SwiftUI.Font.system(size: SUB_SUB_TITLE_SIZE,weight: bold ? .bold : .light)
            }
            static let BIG_TEXT_SIZE: CGFloat = 16
            static let BIG_TEXT: SwiftUI.Font = SwiftUI.Font.system(size: BIG_TEXT_SIZE)
            
            static let NORMAL_TEXT_SIZE: CGFloat = 14
            static let NORMAL_TEXT: SwiftUI.Font = SwiftUI.Font.system(size: NORMAL_TEXT_SIZE)
            static let SMALL_TEXT: SwiftUI.Font = SwiftUI.Font.system(size: 12)
            static let SMALLER_TEXT: SwiftUI.Font = SwiftUI.Font.system(size: 10)
            static let TINY_TEXT: SwiftUI.Font = SwiftUI.Font.system(size: 8)
            static let DEFAULT_SIZE: CGFloat = 16
            static let DEFAULT: SwiftUI.Font = SwiftUI.Font.system(size: DEFAULT_SIZE)
        }
    }

}

extension View {
    @inlinable public func shadow() -> some View {
        self.shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.16), radius: 3.0, x: 0 , y: 3)
    }
}
