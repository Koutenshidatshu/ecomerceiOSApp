//
//  GetProduct.swift
//  ecomerce-iOS
//
//  Created by Yonathan Wijaya on 11/07/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol GetProduct {
    func get() -> Observable<Data>
}

struct GetProductImpl : GetProduct{
    
    func get() -> Observable<Data> {
        let session = URLSession.shared
        let data = session.rx.response(request: requestUrl())
            .map { (_, data) in
                return data
        }.retry(2)
        return handleApiRequestFailed(data)
    }
    
    private func requestUrl() -> URLRequest {
        let url = URL(string: ProductApiURL().path)!
        let urlRequest = URLRequest(url: url)
        return urlRequest
    }
    
    private func handleApiRequestFailed(_ observable: Observable<Data>) -> Observable<Data> {
        return observable.catchError { error -> Observable<Data> in
            if case let .httpRequestFailed(_, data)? = error as? RxCocoaURLError {
                return Observable.from(optional: data)
            } else {
                return .error(error)
            }
        }
    }
}
