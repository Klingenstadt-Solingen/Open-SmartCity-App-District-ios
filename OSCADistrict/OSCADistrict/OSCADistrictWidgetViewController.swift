import OSCAEssentials
import UIKit
import SwiftUI

/**
 Main ViewController for the District Module
 */
public final class OSCADistrictWidgetViewController: UIViewController {
    
    var widgetView: OSCADistrictWidgetView? = nil
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        initializeDistrictWidgetView()
    }
    
    /**
     Initializes the SwiftUI View by creating a UIHostingController and adding it as a subview of the main ViewController
     */
    private func initializeDistrictWidgetView() {
        self.widgetView = OSCADistrictWidgetView()
        let widgetVC = UIHostingController(rootView: self.widgetView)

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
    
    public func getDistrict() -> String?{
        return self.widgetView?.getDistrict()
    }

}
