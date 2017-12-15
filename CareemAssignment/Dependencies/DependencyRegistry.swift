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
//        container.register(DataLayer.self       ) { _ in DataLayerImpl()     }.inObjectScope(.container)
//        container.register(SpyTranslator.self   ) { _ in SpyTranslatorImpl() }.inObjectScope(.container)
//
//        container.register(TranslationLayer.self) { r in
//            TranslationLayerImpl(spyTranslator: r.resolve(SpyTranslator.self)!)
//        }.inObjectScope(.container)
//
//        container.register(ModelLayer.self){ r in
//            ModelLayerImpl(networkLayer:     r.resolve(NetworkLayer.self)!,
//                           dataLayer:        r.resolve(DataLayer.self)!,
//                           translationLayer: r.resolve(TranslationLayer.self)!)
//        }.inObjectScope(.container)
    }
    
    
    func registerDataStores(){
        
        
        container.register(MovieDataStore.self){ r  in
            
                            return RemoteMovieDataStore(network: r.resolve(Networking.self),
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
        
        //        container.register(SpyListPresenter.self) { r in SpyListPresenterImpl(modelLayer: r.resolve(ModelLayer.self)!) }
        //        container.register( DetailPresenter.self) { (r, spy: SpyDTO)  in DetailPresenterImpl(with: spy) }
        //        container.register(SpyCellPresenter.self) { (r, spy: SpyDTO) in SpyCellPresenterImpl(with: spy) }
        //        container.register(SecretDetailsPresenter.self) { (r, spy: SpyDTO) in SecretDetailsPresenterImpl(with: spy) }
    }
   
    
    func registerViewControllers() {
//        container.register(SecretDetailsViewController.self) { (r, spy: SpyDTO) in
//            let presenter = r.resolve(SecretDetailsPresenter.self, argument: spy)!
//            return SecretDetailsViewController(with: presenter, navigationCoordinator: self.navigationCoordinator)
//        }
//        container.register(DetailViewController.self) { (r, spy:SpyDTO) in
//            let presenter = r.resolve(DetailPresenter.self, argument: spy)!
//
//            //NOTE: We don't have access to the constructor for this VC so we are using method injection
//            let vc = UIStoryboard.main.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
//                vc.configure(with: presenter, navigationCoordinator: self.navigationCoordinator)
//            return vc
//        }
    }
    
}
