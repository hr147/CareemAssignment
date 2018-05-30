//
//  AlamofireNetwork.swift
//  Audalize
//
//  Created by Haroon Ur Rasheed on 3/24/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//


import Alamofire
import RxSwift

class AlamofireNetwork: Networking {
    
    let translation:TranslationLayer
    
    init(translation:TranslationLayer) {
        self.translation = translation
    }
    
    let manager:SessionManager = {
        let configuration = URLSessionConfiguration.background(withIdentifier: "com.careemAssigment.app.background")
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    func requestObject<T:Decodable>(_ request: RequestConverterProtocol) -> Observable<ServerResponse<T>>{
        
        return Observable.create {[unowned self] observer in
            
            let request = self.manager
                .request(request)
                .validate()
                .responseDecodable(translation:self.translation){ (response:DataResponse<T>) in
                    //Response detail
                    print(response.request as Any)  // original URL request
                    print(response.response as Any) // HTTP URL response
                    print(response.data as Any)     // server data
                    print(response.result as Any)   // result of response serialization
                    
                    if let _data = response.data, let utf8Text = String(data: _data, encoding: .utf8) {
                        debugPrint(utf8Text)
                    }
                    switch response.result {
                    case .success(let value):
                        observer.onNext(.init(value: value))
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    func requestObject<T:Decodable>(_ request: RequestConverterProtocol,completionHandler: @escaping DataResponseHandler<T>){
        manager
            .request(request)
            .validate()
            .responseDecodable(translation: translation){ (response:DataResponse<T>) in
                print(response.request as Any)  // original URL request
                print(response.response as Any) // HTTP URL response
                print(response.data as Any)     // server data
                print(response.result as Any)   // result of response serialization
                switch response.result {
                case .success(let value):
                    completionHandler(.init(result: .success(value)))
                case .failure(let error as NetworkError):
                    completionHandler(.init(result: .failure(error)))
                default:break
                }
        }
    }
}

extension DataRequest {
    
    @discardableResult
    func responseDecodable<T: Decodable>(
        translation:TranslationLayer,
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (DataResponse<T>) -> Void)
        -> Self
    {
        let responseSerializer = DataResponseSerializer<T> { request, response, data, error in
            guard error == nil else {
                return .failure(NetworkError(error: error! as NSError))
            }
            let jsonResponseSerializer = DataRequest.dataResponseSerializer()
            let result = jsonResponseSerializer.serializeResponse(request, response, data, nil)
            guard case let .success(dataObject) = result else {
                return .failure(NetworkError(error: result.error! as NSError))
            }
            do {
                return .success(try translation.decode(withData: dataObject))
            } catch let error {
                print(error)
                let error:NetworkError = .ServerError(message: "JSON could not be serialized: \(error)")
                return .failure(error)
            }
        }
        return response(queue: queue, responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}
