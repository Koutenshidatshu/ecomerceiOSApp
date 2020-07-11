//
//  Observable+GetEmit.swift
//  ecomerce-iOS
//
//  Created by Yonathan Wijaya on 11/07/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import RxSwift
import RxBlocking

extension Observable {
    func firstEmit() -> Element? {
        return try? toBlocking().first()
    }
    
    func allEmit() -> [Element]? {
        return try? toBlocking().toArray()
    }
}
