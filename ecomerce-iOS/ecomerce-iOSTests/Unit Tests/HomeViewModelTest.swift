//
//  HomeViewModelTest.swift
//  ecomerce-iOSTests
//
//  Created by Yonathan Wijaya on 12/07/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import XCTest
import RxSwift
@testable import ecomerce_iOS

class HomeViewModelTest: XCTestCase {
    private var viewModel: HomeViewModel!
    private var providerMock : ProductProviderMock!
    
    override func setUp() {
        super.setUp()
        providerMock = ProductProviderMock()
        viewModel = HomeViewModel(provider: providerMock)
    }
    
    func testViewDidLoad() {
        let expect = expectation(description: "expect load default product")
        
        let disposable = viewModel.product
            .subscribe(onNext: { _ in
                expect.fulfill()
            })
        
        defer { disposable.dispose() }
        
        viewModel.viewLoad()
        waitForExpectations(timeout: 0.5, handler: nil)
    }
    
    func testGetProductCategoryItemCount() {
        viewModel.viewLoad()
        
        XCTAssertEqual(viewModel.getCategoryItemCount(), 5)
        
    }
    
    func testGetProductPromoItemsCount() {
        viewModel.viewLoad()
        
        XCTAssertEqual(viewModel.getPromoItemCount(), 4)
        
    }
    
    func testCategoryItemAtIndex() {
        let expectedProduct = [Product.init(category: [Category.init(id: 21, imageUrl: "https://img.icons8.com/bubbles/2x/t-shirt.png",
                                                                     name: "Baju")],
                                            productPromo: [])]
        
        viewModel.viewLoad()
        
        XCTAssertEqual(expectedProduct.first?.category[0], viewModel.itemCategory(at: 0))
        
    }
    
    func testPromoItemAtIndex() {
        let expectedProduct = [Product.init(category: [],
                                            productPromo: [ProductPromo.init(id: "6723",
                                                                             imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/7/76/Nintendo-Switch-Console-Docked-wJoyConRB.jpg/430px-Nintendo-Switch-Console-Docked-wJoyConRB.jpg",
                                                                             description: "description",
                                                                             title: "Nitendo Switch",
                                                                             price: "$340",
                                                                             loved: 0)])]
        
        viewModel.viewLoad()
        
        XCTAssertEqual(expectedProduct.first?.productPromo[0], viewModel.itemPromo(at: 0))
        
    }
}


private struct FailableDecodable: Decodable {

    let product: ProductListResponse?

    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            self.product = try container.decode(ProductListResponse.self)
        } catch {
            throw ProductListRequester.RequestError.parseFailure
        }
    }
}

class ProductProviderMock: ProductProvider {
    var product = ProductApiMock().sample
    private var productList: [Product] = []
    
    func get() -> Observable<[ProductListResponse]> {
        return .just(decodeToResponse(from: product)!)
    }
    
    private func decodeToResponse(from jsonString: String) -> [ProductListResponse]? {
        do {
            let data = Data(product.utf8)
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode([FailableDecodable].self, from: data).compactMap { $0.product }
        } catch {
            return nil
        }
    }
    
    func emit(products: [Product]) {
        self.productList = products
    }
}
