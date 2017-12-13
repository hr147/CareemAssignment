import UIKit
import Swinject
import SwinjectStoryboard

// This enables injection of the initial view controller from the app's main
//   storyboard project settings. So, this is the starting point of the
//   dependency tree.
extension SwinjectStoryboard {
    @objc public class func setup() {
        if AppDelegate.dependencyRegistry == nil {
            AppDelegate.dependencyRegistry = SwinjectDependency(container: defaultContainer)
        }
        
        let dependencyRegistry: DependencyRegistry = AppDelegate.dependencyRegistry
        
        func main() {
            dependencyRegistry.container.storyboardInitCompleted(MovieSearchViewController.self) { r, vc in

                let coordinator = dependencyRegistry.makeRootCoordinator(rootViewController: vc)

                setupData(resolver: r, navigationCoordinator: coordinator)

                //let presenter = r.resolve(SpyListPresenter.self)!

                //NOTE: We don't have access to the constructor for this VC so we are using method injection
//                vc.configure(with: presenter,
//            navigationCoordinator: coordinator,
//                     spyCellMaker: dependencyRegistry.makeSpyCell)
            }
        }
        
        func setupData(resolver r: Resolver, navigationCoordinator: RootCoordinator) {
            AppDelegate.rootCoordinator = navigationCoordinator
        }
        
        main()
    }

}
