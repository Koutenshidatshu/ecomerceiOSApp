//
//  GetProduct.swift
//  ecomerce-iOSTests
//
//  Created by Yonathan Wijaya on 11/07/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import XCTest
import RxSwift

@testable import ecomerce_iOS

class GetProductTests: XCTestCase {
    
    func testGetDatas() {
        let jsonString = createRequestString()
        let hasData = jsonString.contains("data")
        XCTAssertTrue(hasData)
        
        let hasField = { (field: String, jsonString: String) in
                   jsonString.contains(#""\#(field)""#)
        }
        XCTAssertTrue(hasField("category" ,jsonString))
        
        let hasCategory = jsonString.contains("category")
        XCTAssertTrue(hasCategory)
        
        let hasProductPromo = jsonString.contains("productPromo")
        XCTAssertTrue(hasProductPromo)
        
    }
    
    private func createRequestString() -> String {
        let data = GetProduct().get().firstEmit()!
        return String(data: data, encoding: .utf8)!
    }
}
