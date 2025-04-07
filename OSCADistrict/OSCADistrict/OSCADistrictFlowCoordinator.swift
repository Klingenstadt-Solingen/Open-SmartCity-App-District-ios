import OSCAEssentials
import Foundation

public final class OSCADistrictFlowCoordinator: Coordinator {
    /**
     `children`property for conforming to `Coordinator` protocol is a list of `Coordinator`s
    
     */
    public var children: [Coordinator] = []
    
    /**
     router injected via initializer: `router` will be used to push and pop view controllers
     */
    public let router: Router
    /**
     District station view controller `OSCADistrictMainViewController`
     */
    weak var districtVC: OSCADistrictMainViewController?
    var deeplinkScheme = "solingen"
    
    public init(router: Router) {
        self.router = router
    }
    
    public func showDistrictMain(animated: Bool,
                                 deeplink: URL?,
                                 onDismissed: (() -> Void)?) -> Void {
        
        let vc = OSCADistrictMainViewController.create()
        self.router.present(vc,
                            animated: animated,
                            onDismissed: onDismissed)
        self.districtVC = vc
    }// end func showDistrictMain
    
    public func present(animated: Bool, onDismissed: (() -> Void)?) {
        // Unused but needed to conform to Coordinator
    }// end public func present
}
