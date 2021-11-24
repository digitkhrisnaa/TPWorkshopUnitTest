//
//  ThirdNetworkProvider.swift
//  TPWorkshopUnitTest
//
//  Created by digital.aurum on 19/11/21.
//

import Foundation

protocol AdvancedNetworkProvider {
    func fetchProduct() -> NetworkResult<ProductResult>
}

struct AdvancedUseCase: AdvancedNetworkProvider {
    func fetchProduct() -> NetworkResult<ProductResult> {
        guard let url = Bundle.main.path(forResource: "ProductData", ofType: "json") else {
            return .failed("URL Not found")
        }
        
        if let data = try? Data(contentsOf: URL(fileURLWithPath: url), options: .mappedIfSafe) {
            if let result = try? JSONDecoder().decode(ProductResult.self, from: data) {
                return .success(result)
            } else {
                return .failed("Failed when decoding")
            }
        } else {
            return .failed("Failed converting to data")
        }
    }
}
