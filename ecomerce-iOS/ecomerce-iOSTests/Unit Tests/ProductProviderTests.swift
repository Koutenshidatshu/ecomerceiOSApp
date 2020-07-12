//
//  ProductProviderTests.swift
//  ecomerce-iOSTests
//
//  Created by Yonathan Wijaya on 11/07/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import XCTest
import RxSwift
@testable import ecomerce_iOS

class ProductProviderTests: XCTestCase {
    func testGetProductWithValidResponse() {
        let api = ProductApiMock()
        let products = ProductProviderImpl(service: api).get()
        
        XCTAssertNotNil(products)
        let result = products.firstEmit()?.first?.data
        XCTAssertEqual(result?.category.count, 5)
        XCTAssertEqual(result?.productPromo.count, 4)
    }
    
    func testGetProductWithResponseError() {
        let api = ProductApiErrorMock()
        let products = ProductProviderImpl(service: api).get()
        XCTAssertNotNil(products)
        
        XCTAssertThrowsError(try products.toBlocking().first())
        XCTAssertNil(products.firstEmit()?.first?.data)
    }
    
    func testGetProductWithEmptyResponse() {
        let api = ProductApiEmptyMock()
        let products = ProductProviderImpl(service: api).get()
        XCTAssertNotNil(products)
        
        XCTAssertThrowsError(try products.toBlocking().first())
        XCTAssertNil(products.firstEmit()?.first?.data)
    }
    
}

class ProductApiErrorMock: GetProduct {
    func get() -> Observable<Data> {
        return .error(RxError.timeout)
    }
}

class ProductApiMock: GetProduct {
    let sample = {
        """
    [
        {
            "data": {
                "category": [
                    {
                        "imageUrl": "https://img.icons8.com/bubbles/2x/t-shirt.png",
                        "id": 21,
                        "name": "Baju"
                    },
                    {
                        "imageUrl": "https://img.icons8.com/flat_round/2x/long-shorts.png",
                        "id": 42,
                        "name": "Celana"
                    },
                    {
                        "imageUrl": "https://img.icons8.com/flat_round/2x/summer-hat.png",
                        "id": 11,
                        "name": "Topi"
                    },
                    {
                        "imageUrl": "https://img.icons8.com/color/2x/red-purse.png",
                        "id": 91,
                        "name": "Tas"
                    },
                    {
                        "imageUrl": "https://img.icons8.com/cute-clipart/2x/apple-watch-apps.png",
                        "id": 131,
                        "name": "Jam Tangan"
                    }
                ],
                "productPromo": [
                    {
                        "id": "6723",
                        "imageUrl": "https://upload.wikimedia.org/wikipedia/commons/thumb/7/76/Nintendo-Switch-Console-Docked-wJoyConRB.jpg/430px-Nintendo-Switch-Console-Docked-wJoyConRB.jpg",
                        "title": "Nitendo Switch",
                        "description": "description",
                        "price": "$340",
                        "loved": 0
                    },
                    {
                        "id": "6724",
                        "imageUrl": "https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/NES-Console-Set.jpg/430px-NES-Console-Set.jpg",
                        "title": "Nitendo Entertainment System ",
                        "description": "Released July 15, 1983, the Nintendo Entertainment System (NES) is an 8-bit video game console released by Nintendo in North America, South America, Europe, Asia, Oceania and Africa and was Nintendo's first home video game console released outside Japan. In Japan, it is known as the Family Computer (or Famicom, as it is commonly abbreviated). Selling 61.91 million units worldwide, the NES helped revitalize the video game industry following the video game crash of 1983 and set the standard for subsequent consoles in everything from game design to business practices. The NES was the first console for which the manufacturer openly courted third-party developers. Many of Nintendo's most iconic franchises, such as The Legend of Zelda and Metroid were started on the NES. Nintendo continued to repair Famicom consoles in Japan until October 31, 2007, attributing the decision to discontinue support to an increasing shortage of the necessary parts.[4][5][6]Nintendo released a software-emulation-based version of the Nintendo Entertainment System on November 10, 2016. Called the NES Classic Edition, it is a dedicated console that comes with a single controller and 30 preloaded games.[7]",
                        "price": "$70",
                        "loved": 1
                    },
                    {
                        "id": "6725",
                        "imageUrl": "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d5/Nintendo-ds-lite.svg/430px-Nintendo-ds-lite.svg.png",
                        "title": "Nitendo DS Lite ",
                        "description": "The Nintendo DS (abbreviated NDS, DS, or the full name Nintendo Dual Screen, and iQue DS in China) is a handheld game console developed and manufactured by Nintendo, released in 2004. It is visibly distinguishable by its horizontal clamshell design, and the presence of two displays, the lower of which acts as a touchscreen. The system also has a built-in microphone and supports wireless IEEE 802.11 (Wi-Fi) standards, allowing players to interact with each other within short range (10–30 meters, depending on conditions) or over the Nintendo Wi-Fi Connection service via a standard Wi-Fi access point. According to Nintendo, the letters DS in the name stand for Developers' System and Double Screen, the former of which refers to the features of the handheld designed to encourage innovative gameplay ideas among developers.[43] The system was known as Project Nitro during development.",
                        "price": "$110",
                        "loved": 1
                    },
                    {
                        "id": "6726",
                        "imageUrl": "https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Wii-console.jpg/430px-Wii-console.jpg",
                        "title": "Nitendo WII ",
                        "description": "The Nintendo DS (abbreviated NDS, DS, or the full name Nintendo Dual Screen, and iQue DS in China) is a handheld game console developed and manufactured by Nintendo, released in 2004. It is visibly distinguishable by its horizontal clamshell design, and the presence of two displays, the lower of which acts as a touchscreen. The system also has a built-in microphone and supports wireless IEEE 802.11 (Wi-Fi) standards, allowing players to interact with each other within short range (10–30 meters, depending on conditions) or over the Nintendo Wi-Fi Connection service via a standard Wi-Fi access point. According to Nintendo, the letters DS in the name stand for Developers' System and Double Screen, the former of which refers to the features of the handheld designed to encourage innovative gameplay ideas among developers.[43] The system was known as Project Nitro during development.",
                        "price": "$200",
                        "loved": 0
                    }
                ]
            }
        }
    ]
    """
    }()
    
    func get() -> Observable<Data> {
        return .just(sample.data(using: .utf8)!)
    }
}
class ProductApiEmptyMock: GetProduct {
    func get() -> Observable<Data> {
        return .just("".data(using: .utf8)!)
    }
}
