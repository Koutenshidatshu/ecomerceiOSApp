//
//  ProductListResponseTest.swift
//  ecomerce-iOSTests
//
//  Created by Yonathan Wijaya on 11/07/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import XCTest
import  RxSwift
@testable import ecomerce_iOS

class ProductListResponseTest: XCTestCase {
    
    private let emptyData = {
        return """
        [
            {
                "data": {}
            }
        ]
        """
    }()
    
    private let validData = {
        """
        [
            {
                "data": {
                    "category": [
                        {
                            "imageUrl": "category image",
                            "id": 21,
                            "name": "Baju"
                        }
                    ],
                    "productPromo": [
                        {
                            "id": "6723",
                            "imageUrl": "product promo image",
                            "title": "Nitendo Switch",
                            "description": "The Nintendo Switch was released",
                            "price": "$340",
                            "loved": 0
                        }
                    ]
                }
            }
        ]
        """
    }()
    
    private let invalidData = {
        """
        {}
        """
    }()
    
    func testParseProductsWithEmptyData() {
        let disposeBag = DisposeBag()
        let productListResponse = ProductListRequester(requestProducts: .just(emptyData.data(using: .utf8)!))
        var result: ProductListResponse?
        var capturedError : ProductListRequester.RequestError?
        
        productListResponse.request()
            .subscribe(onSuccess: { result = $0.first },
                       onError: { capturedError = ($0 as? ProductListRequester.RequestError) })
            .disposed(by: disposeBag)
        
        XCTAssertNil(result)
        XCTAssertEqual(capturedError, .parseFailure)
        
    }
    
    func testParseProductsWithValidData() {
        let disposeBag = DisposeBag()
        let productListResponse = ProductListRequester(requestProducts:
            .just(validData.data(using: .utf8)!))
        var result: ProductListResponse?
        
        productListResponse.request()
            .subscribe(onSuccess: { result = $0.first },
                       onError: { XCTFail("fail with error \($0.localizedDescription)") })
            .disposed(by: disposeBag)
        
        XCTAssertNotNil(result)
        XCTAssertGreaterThan(result!.data.category.count, 0)
        XCTAssertEqual(result!.data.category.first!.id, 21)
        XCTAssertEqual(result!.data.category.first!.imageUrl, "category image")
        XCTAssertEqual(result!.data.category.first!.name, "Baju")
        
        
        XCTAssertGreaterThan(result!.data.productPromo.count, 0)
        XCTAssertEqual(result!.data.productPromo.first!.id, "6723")
        XCTAssertEqual(result!.data.productPromo.first!.imageUrl, "product promo image")
        XCTAssertEqual(result!.data.productPromo.first!.description, "The Nintendo Switch was released")
        XCTAssertEqual(result!.data.productPromo.first!.title, "Nitendo Switch")
        XCTAssertEqual(result!.data.productPromo.first!.price, "$340")
        XCTAssertEqual(result!.data.productPromo.first!.loved, 0)
    }
    
    func testWithInvalidData() {
        let disposeBag = DisposeBag()
        let productListResponse = ProductListRequester(requestProducts:
            .just(invalidData.data(using: .utf8)!))
        var capturedError : ProductListRequester.RequestError?
        
        productListResponse.request()
            .subscribe(onError: { capturedError = ($0 as? ProductListRequester.RequestError) })
            .disposed(by: disposeBag)
        XCTAssertEqual(capturedError, .parseFailure)
    }
}
