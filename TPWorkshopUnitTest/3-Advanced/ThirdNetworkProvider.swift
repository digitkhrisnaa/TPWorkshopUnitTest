//
//  ThirdNetworkProvider.swift
//  TPWorkshopUnitTest
//
//  Created by digital.aurum on 19/11/21.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case failed(String)
}

protocol ThirdNetworkProvider {
    func fetchProduct() -> NetworkResult<ProductResult>
}

struct ThirdUseCase: ThirdNetworkProvider {
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
