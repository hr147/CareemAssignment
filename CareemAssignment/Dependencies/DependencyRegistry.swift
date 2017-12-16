import UIKit
import Swinject
import SwinjectStoryboard

protocol DependencyRegistry {
    
    var container: Container { get }
    
    
}

class SwinjectDependency: DependencyRegistry {
    
    var container: Container
    weak var rootCoordinator: RootCoordinator!
    
    
    init(container: Container) {
        
        Container.loggingFunction = nil
        
        self.container = container
        
        registerDependencies()
        registerDataStores()
        registerViewModels()
        registerViewControllers()
    }
    
    func registerDependencies() {
        
        
        container.register(Networking.self) { _ in AlamofireNetwork()  }.inObjectScope(.container)
        container.register(TranslationLayer.self) { _ in JSONTranslation()  }.inObjectScope(.container)
        
        if #available(iOS 10.0, *){
            
            container.register(CareemDataLayer.self) { _ in CoreDataLayer()  }.inObjectScope(.container)
            
        }
        
    }
    
    
    func registerDataStores(){
        
        
        container.register(MovieDataStore.self){ r  in
            
            return AlamofireMovieDataStore(network: r.resolve(Networking.self),
                                           translation: r.resolve(TranslationLayer.self))
            
            
        }
        
        
        container.register(QueryDataStore.self) { r in
            
            return CoreDataQueryDataStore(dataLayer: r.resolve(CareemDataLayer.self))
            
        }
        
    }
    
    func registerViewModels() {
        
        
        container.register(MovieSearchViewModeling.self) { r in
            
            let movieDataStore = r.resolve(MovieDataStore.self)!
            let queryDataStore = r.resolve(QueryDataStore.self)!
            
            return MovieSearchViewModel(movieDataStore: movieDataStore, queryDataStore: queryDataStore)
        }
        
        
    }
    
    
    func registerViewControllers() {
        
//        container.register(QueryTableViewController.self) { r, vc in
//            
//            vc.queryViewModel = r.resolve(QueryViewModeling.self)
//            
//        }
        
    }
    
}
