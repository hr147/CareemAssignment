//
//  AlamofireNetwork.swift
//  Audalize
//
//  Created by Haroon Ur Rasheed on 3/24/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//


import Alamofire

class AlamofireNetwork: Networking {
    
    let manager = SessionManager.default
    
    //private let queue = DispatchQueue(label: "NailPolishApp.Network.Queue", attributes: [])
    
    
//    func requestObject<T:Mappable>(_ router: APIRoutering,completionHandler: @escaping NPResponseHandler<T>) {
//        
//        let alamoRouter = AlamofireRouterRequest(router)
//        
//        self.manager
//            .request(alamoRouter)
//            .validate()
//            .responseObject(completionHandler: { (alamofireResponse: DataResponse<T>) in
//                
//                print(alamofireResponse.request as Any)  // original URL request
//                print(alamofireResponse.response as Any) // HTTP URL response
//                print(alamofireResponse.data as Any)     // server data
//                print(alamofireResponse.result)   // result of response serialization
//                
//                if let _data = alamofireResponse.data, let utf8Text = String(data: _data, encoding: .utf8) {
//                    debugPrint(utf8Text)
//                    
//                    //let data = Mapper<BaseAPIResponseModel>().map(JSONString: utf8Text)
//                    
//                    //print(String(describing: data))
//                    
//                }
//                
//                
//                
//                switch alamofireResponse.result {
//                    
//                case .failure(let error):
//                    
//                    
//                    let error = NetworkError(error: error as NSError)
//                    let response = NPResponseModel<T>(result: .failure(error))
//                    
//                    
//                    print(error.localizedDescription)
//                    print("Status code\(String(describing: alamofireResponse.response?.statusCode))")
//                    print("Error code\((error as NSError).code)")
//                    
//                    completionHandler(response)
//                
//                case .success(let value):
//                    
//                    let response = NPResponseModel<T>(result: .success(value))
//                    
//                    completionHandler(response)
//                    
//                }
//                
//                
//            })
//        
//        
//        
//        
//        
//        
//        
//    }
//    
//    
//    func requestArray<T:Mappable>(_ router: APIRoutering,completionHandler: @escaping NPResponseHandler<[T]>) {
//    
//        let alamoRouter = AlamofireRouterRequest(router)
//        
//        
//
//        self.manager
//            .request(alamoRouter)
//            .validate()
//            .responseArray(completionHandler: { (alamofireResponse: DataResponse<[T]>) in
//                
//                print(alamofireResponse.request as Any)  // original URL request
//                print(alamofireResponse.response as Any) // HTTP URL response
//                print(alamofireResponse.data as Any)     // server data
//                print(alamofireResponse.result)   // result of response serialization
//                
//                if let _data = alamofireResponse.data, let utf8Text = String(data: _data, encoding: .utf8) {
//                    debugPrint(utf8Text)
//                    
//                    //let data = Mapper<BaseAPIResponseModel>().map(JSONString: utf8Text)
//                    
//                    //print(String(describing: data))
//                    
//                }
//                
//                
//                
//                switch alamofireResponse.result {
//                    
//                case .failure(let error):
//                    
//                    
//                    let error = NetworkError(error: error as NSError)
//                    let response = NPResponseModel<[T]>(result: .failure(error))
//                    
//                    
//                    print(error.localizedDescription)
//                    print("Status code\(String(describing: alamofireResponse.response?.statusCode))")
//                    print("Error code\((error as NSError).code)")
//                    
//                    completionHandler(response)
//                    
//                case .success(let value):
//                    
//                    let response = NPResponseModel<[T]>(result: .success(value))
//                    
//                    completionHandler(response)
//                    
//                }
//                
//                
//            })
//        
//            
//    }
    
    
    
}
