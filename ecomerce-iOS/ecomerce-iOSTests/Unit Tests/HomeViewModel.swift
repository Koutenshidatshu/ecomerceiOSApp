//
//  HomeViewModel.swift
//  ecomerce-iOS
//
//  Created by Yonathan Wijaya on 12/07/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel {
    lazy var product: Observable<Product> = productRelay.asObservable()
    
    private var products = [Product]()
    private let provider : ProductProvider
    private let disposeBag = DisposeBag()
    private let productRelay = PublishRelay<Product>()
    
    init(provider: ProductProvider) {
        self.provider = provider
    }
    
    func viewLoad() {
        provider.get()
            .subscribe(onNext: { [weak self] result in
                guard let productData = result.first?.data else { return }
                self?.products.append(productData)
                self?.productRelay.accept(productData)
                
        }).disposed(by: disposeBag)
    }
    
    func getCategoryItemCount() -> Int {
        guard let categoryItems = products.first?.category else { return 0 }
        return categoryItems.count
    }
    
    func getPromoItemCount() -> Int {
        guard let promoItems = products.first?.productPromo else { return 0 }
        return promoItems.count
    }
    
    func itemCategory(at index: Int) -> Category? {
        return products.first?.category[index]
    }
    
    func itemPromo(at index: Int) -> ProductPromo? {
        return products.first?.productPromo[index]
    }
    
}
