//
//  ThirdNetworkProvider.swift
//  TPWorkshopUnitTest
//
//  Created by digital.aurum on 19/11/21.
//

import Foundation

protocol AdvancedNetworkProvider {
    func fetchProduct(onComplete: @escaping (NetworkResult<ProductResult>) -> Void)
}

struct AdvancedUseCase: AdvancedNetworkProvider {
    func fetchProduct(onComplete: @escaping (NetworkResult<ProductResult>) -> Void) {
        guard let url = Bundle.main.path(forResource: "ProductData", ofType: "json") else {
            return onComplete(.failed("URL Not found"))
        }
        
        if let data = try? Data(contentsOf: URL(fileURLWithPath: url), options: .mappedIfSafe) {
            if let result = try? JSONDecoder().decode(ProductResult.self, from: data) {
                return onComplete(.success(result))
            } else {
                return onComplete(.failed("Failed when decoding"))
            }
        } else {
            return onComplete(.failed("Failed converting to data"))
        }
    }
}
