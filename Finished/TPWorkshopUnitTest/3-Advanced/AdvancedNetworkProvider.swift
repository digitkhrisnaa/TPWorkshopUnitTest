//
//  ThirdNetworkProvider.swift
//  TPWorkshopUnitTest
//
//  Created by digital.aurum on 19/11/21.
//

import Foundation

protocol AdvancedNetworkProvider {
    func fetchProduct(completion: @escaping ((NetworkResult<ProductResult>) -> Void))
}

struct AdvancedUseCase: AdvancedNetworkProvider {
    func fetchProduct(completion: @escaping ((NetworkResult<ProductResult>) -> Void)) {
        guard let url = Bundle.main.path(forResource: "ProductData", ofType: "json") else {
            completion(.failed("URL Not found"))
            return
        }
        
        if let data = try? Data(contentsOf: URL(fileURLWithPath: url), options: .mappedIfSafe) {
            if let result = try? JSONDecoder().decode(ProductResult.self, from: data) {
                completion(.success(result))
            } else {
                completion(.failed("Failed when decoding"))
            }
        } else {
            completion(.failed("Failed converting to data"))
        }
    }
}
