//
//  ProductsProvider.swift
//  ecomerce-iOS
//
//  Created by Yonathan Wijaya on 11/07/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import Foundation
import RxSwift

protocol ProductProvider{
    func get() -> Observable<[ProductListResponse]>
}

struct ProductProviderImpl: ProductProvider {
    private let service: GetProduct
    
    init(service: GetProduct) {
        self.service = service
    }
    
    func get() -> Observable<[ProductListResponse]> {
        let requester = ProductListRequester(requestProducts: service.get())
        return requester.request().asObservable()
    }
}

struct ProductProviderFactory {
    static func create() -> ProductProvider {
        return ProductProviderImpl(service: GetProductImpl())
    }
}
