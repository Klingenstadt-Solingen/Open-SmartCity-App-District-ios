import OSCAEssentials
import UIKit
import SwiftUI

public final class OSCAEventsWidgetViewController: UIViewController {
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        initializeEventsWidgetView()
    }
    

    private func initializeEventsWidgetView() {
        let root = ZStack {
            EventWidgetView(onClick: { objectId in
                DispatchQueue.main.async {
                    if let url = URL(string: "solingen://events/detail?object=\(objectId)") {
                        UIApplication.shared.open(url)
                    }
                }
            }).padding(.horizontal, DistrictDesign.Padding.BIG)
        }.frame(width: view.bounds.width, height: 170)
        
        let widgetVC = UIHostingController(rootView: root)
        addChild(widgetVC)
        widgetVC.view.frame = view.bounds
        view.addSubview(widgetVC.view)
        // Making the subview fill the maximum available space
        widgetVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widgetVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            widgetVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            widgetVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            widgetVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        widgetVC.didMove(toParent: self)
    }
}
