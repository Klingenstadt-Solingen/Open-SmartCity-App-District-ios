import OSCAEssentials

/**
 Every isolated module feature will have its own Dependency Injection Container,
 to have one entry point where we can see all dependencies and injections of the module
 */
final class OSCADistrictDIContainer {

  public init() {
  }
    
    func makeDistrictFlowCoordinator(router: Router) -> OSCADistrictFlowCoordinator {
        return OSCADistrictFlowCoordinator(router: router)
  }

  func makeOSCADistrictMainViewController() -> OSCADistrictMainViewController {
    return OSCADistrictMainViewController.create()
  }
}
