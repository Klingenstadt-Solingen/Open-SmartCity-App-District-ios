import Foundation
import MapKit
import SwiftUI

final class MapAnnotationView<T, Content: View>: MKAnnotationView {
    
    init(mapAnnotation: MapAnnotation<T, Content>, reuseIdentifier: String?) {
        super.init(annotation: mapAnnotation, reuseIdentifier: reuseIdentifier)
        frame = CGRect(x: 0, y: 0, width: 30, height: 40)
        centerOffset = CGPoint(x: 0, y: -frame.size.height / 2)
        backgroundColor = .clear
        
        let view = UIHostingController(rootView: mapAnnotation.content).view!
        
        addSubview(view)
        view.frame = bounds
        view.backgroundColor = UIColor.clear
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
