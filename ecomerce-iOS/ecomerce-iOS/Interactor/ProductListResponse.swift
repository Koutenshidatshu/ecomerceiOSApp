//
//  ProductListResponse.swift
//  ecomerce-iOS
//
//  Created by Yonathan Wijaya on 11/07/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//
import Foundation
import RxSwift

struct ProductListResponse : Decodable {
    let data: Product
}

struct Product: Decodable {
    let category: [Category]
    let productPromo: [ProductPromo]
}

struct Category: Decodable {
    let id: Int
    let imageUrl: String
    let name: String
}

struct ProductPromo: Decodable {
    let id: String
    let imageUrl: String
    let description: String
    let title: String
    let price: String
    let loved: Int
}


struct ProductListRequester {
    enum RequestError : Error {
        case parseFailure
    }
    
    let request: () -> Single<[ProductListResponse]>
}

extension ProductListRequester {
    init(requestProducts: Observable<Data>) {
        request = {
            requestProducts
                .map { try ProductListResponse.parseResponse(from: $0) }
                .take(1)
                .asSingle()
        }
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

private extension ProductListResponse {
    static func parseResponse(from data: Data) throws -> [ProductListResponse] {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode([FailableDecodable].self, from: data).compactMap { $0.product }
        } catch {
            throw ProductListRequester.RequestError.parseFailure
        }
    }
}
