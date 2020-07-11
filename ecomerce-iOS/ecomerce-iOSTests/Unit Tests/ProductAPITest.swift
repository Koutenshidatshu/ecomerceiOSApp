//
//  ProductAPITest.swift
//  ecomerce-iOSTests
//
//  Created by Yonathan Wijaya on 11/07/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import XCTest
@testable import ecomerce_iOS

class ProductAPITest: XCTestCase {

    func testURLPath() {
        let urlPath = ProductApiURL()
        
        let expectedUrl = "https://private-4639ce-ecommerce56.apiary-mock.com/home"
        
        XCTAssertEqual(expectedUrl, urlPath.path)
    }

}
