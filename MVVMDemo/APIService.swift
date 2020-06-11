//
//  APIService.swift
//  MVVMDemo
//
//  Created by Steven Hsieh on 2020/6/5.
//  Copyright © 2020 Steven Hsieh. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class APIService{
    
    static let shared = APIService()
    lazy var requestObservable = RequestObservable()
    private let url: String
    
    private init(){
        url = "https://api.unsplash.com/photos/?client_id=812193ef71ca946e361ed541979a0cfd91e9419a19235fd05f51ea14233f020a&per_page=5"
    }
    
    func getPhoto() throws -> Observable<[PhotoModel]>?{
        guard let url = URL(string: url) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return requestObservable.callAPI(request: request)
    }
    
    
}

class RequestObservable {
        
    func callAPI<ItemModel: Decodable>(request: URLRequest) -> Observable<ItemModel> {
        return Observable.create { observer in
                
            let task = URLSession.shared.dataTask(with: request) { (data, resopnse, error) in
                do{
                    let model = try JSONDecoder().decode(ItemModel.self, from: data ?? Data())
                    observer.onNext(model)
                }catch let error {
                    observer.onError(error)
                }
                observer.onCompleted()
                
            }
            task.resume()
            
            return Disposables.create{
                task.cancel()
            }
        }
        
    }
    
}
