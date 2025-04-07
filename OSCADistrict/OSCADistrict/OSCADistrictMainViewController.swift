import OSCAEssentials
import UIKit
import SwiftUI

/**
 Main ViewController for the District Module
 */
public final class OSCADistrictMainViewController: UIViewController {
    public override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true;
       
      //  self.navigationController?.tabBarController?.tabBar.isHidden = true;
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = UIColor.white
        
        initializeDistrictView()
    }

    /**
     Initializes the SwiftUI View by creating a UIHostingController and adding it as a subview of the main ViewController
     */
    private func initializeDistrictView() {
        let mainViewVC = UIHostingController(
            rootView: BootstrapApp(
                height: (self.navigationController?.toolbar.frame.height ?? 0.0) +  (
                    self.navigationController?.toolbar.safeAreaInsets.bottom ?? 0.0
                )
            )
        )
        addChild(mainViewVC)
        mainViewVC.view.frame = view.bounds
        view.addSubview(mainViewVC.view)
        // Making the subview fill the maximum available space
        mainViewVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainViewVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainViewVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainViewVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            mainViewVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        mainViewVC.didMove(toParent: self)
    }
}

extension OSCADistrictMainViewController: StoryboardInstantiable {
    public static func create() -> OSCADistrictMainViewController {
        let vc = Self.instantiateViewController(OSCADistrict.bundle)
        return vc
    }
}
