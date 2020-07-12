//
//  ProductsProvider.swift
//  ecomerce-iOS
//
//  Created by Yonathan Wijaya on 11/07/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import Foundation
import RxSwift

struct ProductProvider {
    private let service: GetProduct
    
    init(service: GetProduct) {
        self.service = service
    }
    
    func get() -> Observable<[ProductListResponse]>  {
        let requester = ProductListRequester(requestProducts: service.get())
        return requester.request().asObservable()
    }
}


