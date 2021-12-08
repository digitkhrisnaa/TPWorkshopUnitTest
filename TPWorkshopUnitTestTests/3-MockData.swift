//
//  MockData.swift
//  TPWorkshopUnitTestTests
//
//  Created by digital.aurum on 19/11/21.
//

import Foundation
@testable import TPWorkshopUnitTest

struct MockProductData {
    static func generateProductResult() -> ProductResult {
        return ProductResult(data: [
            Product(id: 1,
                    name: "lorem ipsum",
                    imageURL: nil,
                    price: "Rp 100",
                    shop: Shop(id: 1,
                               name: "toko serba ada",
                               location: "Indonesia"))
        ])
    }
}

struct MockPositiveWorkshopProvider: AdvancedNetworkProvider {
    func fetchProduct(completion: @escaping ((NetworkResult<ProductResult>) -> Void)) {
        let result = MockProductData.generateProductResult()
        
        completion(.success(result))
    }
}

struct MockNegativeWorkshopProvider: AdvancedNetworkProvider {
    func fetchProduct(completion: @escaping ((NetworkResult<ProductResult>) -> Void)) {
        completion(.failed("failed"))
    }
}
