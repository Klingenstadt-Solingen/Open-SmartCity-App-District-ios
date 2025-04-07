import OSCAEssentials
import Foundation

public struct OSCADistrictDependencies {
  let moduleConfig: OSCADistrictConfig
  
  public init(moduleConfig: OSCADistrictConfig) {
    self.moduleConfig   = moduleConfig
  }
}

public struct OSCADistrictConfig {
  /// module title
  public var title: String?
  /// app deeplink scheme URL part before `://`
  public var deeplinkScheme: String = "solingen"
  
  public init(title: String?,
              deeplinkScheme: String = "solingen") {
    self.title = title
    self.deeplinkScheme = deeplinkScheme
  }
}

public struct OSCADistrict {
  /// module DI container
  private var moduleDIContainer: OSCADistrictDIContainer!
  public var version: String = "0.9.0"
  public var bundlePrefix: String = "de.nedeco-osca.District"
    private static var _bundle: Bundle?
  public internal(set) static var configuration: OSCADistrictConfig!
  /// module `Bundle`
  ///
  /// **available after module initialization only!!!**
    public static var bundle: Bundle {
        get {
            if _bundle == nil {
#if SWIFT_PACKAGE
                _bundle = Bundle.module
#else
                guard let newBundle: Bundle = Bundle(identifier: self.bundlePrefix) else { fatalError("Module bundle not initialized!") }
                _bundle = newBundle
#endif
            }
            return _bundle!
        }
    }
  
  /**
   create module and inject module dependencies
   - Parameter mduleDependencies: module dependencies
   */
  public static func create(with moduleDependencies: OSCADistrictDependencies) -> OSCADistrict {
      var module: Self = Self.init(config: moduleDependencies.moduleConfig)
    module.moduleDIContainer = OSCADistrictDIContainer()
    return module
  }
  
  /// public initializer with module configuration
  /// - Parameter config: module configuration
  public init(config: OSCADistrictConfig) {
/*#if SWIFT_PACKAGE
    Self.bundle = Bundle.module
#else
    guard let bundle: Bundle = Bundle(identifier: self.bundlePrefix) else { fatalError("Module bundle not initialized!") }
    Self.bundle = bundle
#endif*/
    OSCADistrict.configuration = config
  }
  
  /**
   public module interface `getter`for `OSCADistrictFlowCoordinator`
   - Parameter router: router needed or the navigation graph
   */
    public func getDistrictFlowCoordinator(router: Router) -> OSCADistrictFlowCoordinator {
    let flow = self.moduleDIContainer.makeDistrictFlowCoordinator(router: router)
    return flow
  }
}
