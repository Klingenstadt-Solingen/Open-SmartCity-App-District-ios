import Foundation
import MapKit
import SwiftUI

final class PoiAnnotationView<T, Content: View>: MKAnnotationView {
    
    init(poiAnnotation: PoiAnnotation<T, Content>, reuseIdentifier: String?) {
        super.init(annotation: poiAnnotation, reuseIdentifier: reuseIdentifier)
        frame = CGRect(x: 0, y: 0, width: 30, height: 40)
        centerOffset = CGPoint(x: 0, y: -frame.size.height / 2)
        backgroundColor = .clear
        
        let view = UIHostingController(rootView: poiAnnotation.content).view!
        
        addSubview(view)
        view.frame = bounds
        view.backgroundColor = .clear
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
