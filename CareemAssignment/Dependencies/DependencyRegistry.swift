import UIKit
import Swinject
import SwinjectStoryboard

protocol DependencyRegistry {
    var container: Container { get }
}

class SwinjectDependency: DependencyRegistry {
    let container: Container
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
        container.register(TranslationLayer.self) { _ in JSONTranslation() }.inObjectScope(.container)
        container.register(Networking.self) {
            AlamofireNetwork(translation: $0.resolve(TranslationLayer.self)!)
            }.inObjectScope(.container)
        if #available(iOS 10.0, *){
            container.register(CareemDataLayer.self) { _ in CoreDataLayer()  }.inObjectScope(.container)
        }else{
            container.register(CareemDataLayer.self) { _ in CoreDataOlderLayer()  }.inObjectScope(.container)
        }
    }
    
    func registerDataStores(){
        container.register(MovieDataStore.self){
            AlamofireMovieDataStore(
                network: $0.resolve(Networking.self)!,
                translation: $0.resolve(TranslationLayer.self)!)
        }
        container.register(QueryDataStore.self) {
            CoreDataQueryDataStore(dataLayer: $0.resolve(CareemDataLayer.self))
        }
    }
    
    func registerViewModels() {
        container.register(MovieSearchViewModeling.self) {
            MovieSearchViewModel(
                movieDataStore: $0.resolve(MovieDataStore.self)!,
                queryDataStore: $0.resolve(QueryDataStore.self)!)
        }
    }
    func registerViewControllers() {
        
        
    }
    
}
