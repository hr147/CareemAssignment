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
    
    
    func requestObject<T:Codable>(_ router: APIRoutering,completionHandler: @escaping DataResponseHandler<T>) {
        
        let alamoRouter = AlamofireRouterRequest(router)
        
    
        
        self.manager
            .request(alamoRouter)
            .validate()
            .responseData { response in
                
                print(response.request as Any)  // original URL request
                print(response.response as Any) // HTTP URL response
                print(response.data as Any)     // server data
                print(response.result as Any)   // result of response serialization
                
                
                switch response.result {
                    
                case .success(let value):
                    
                    do {
                        let decoder = JSONDecoder()
                        let model = try decoder.decode(T.self, from: value)
                        
                        let response = DataResponseModel<T>(result: .success(model))
                        
                        completionHandler(response)
                        
                        
                    } catch{
                        
                        let error:NetworkError = .ServerError(message: "Json is not properly parsed")
                        let response = DataResponseModel<T>(result: .failure(error))
                        completionHandler(response)
                    }
                    
                case .failure(let error):
                    print(error)
                    
                    let error = NetworkError(error: error as NSError)
                    let response = DataResponseModel<T>(result: .failure(error))
                    completionHandler(response)
                }
        }
        
//        self.manager
//            .request(alamoRouter)
//            .validate()
//            .responseJSON(completionHandler: { (alamofireResponse: DataResponse<T>) in
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
////                    let error = NetworkError(error: error as NSError)
////                    let response = NPResponseModel<T>(result: .failure(error))
////
//
//                    print(error.localizedDescription)
//                    print("Status code\(String(describing: alamofireResponse.response?.statusCode))")
//                    print("Error code\((error as NSError).code)")
//
//                    //completionHandler(response)
//
//                case .success(let value):
//
////                    let response = NPResponseModel<T>(result: .success(value))
////
////                    completionHandler(response)
//
//                }
//
//
//                } as! (DataResponse<Any>) -> Void)
//
//
//
        
        
        
        
    }
    
    
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
//
    
    
}
