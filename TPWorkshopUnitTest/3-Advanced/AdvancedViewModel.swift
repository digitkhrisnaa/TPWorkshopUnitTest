//
//  ThirdViewModel.swift
//  TPWorkshopUnitTest
//
//  Created by digital.aurum on 19/11/21.
//

import Foundation

class AdvancedViewModel {
    // MARK: Properties
    let useCase: AdvancedNetworkProvider
    var products: [Product] = []
    
    init(useCase: AdvancedNetworkProvider) {
        self.useCase = useCase
    }
    
    // MARK: Output
    var receiveData: (() -> Void)?
    var onErrorReceiveData: ((String) -> Void)?
    var doSideEffect: ((String) -> Void)?
    
    // MARK: Input
    func didLoad() {
        let result: NetworkResult<ProductResult>
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        result = useCase.fetchProduct()
        dispatchGroup.leave()
        
        dispatchGroup.notify(queue: .main) {
            switch result {
            case let .success(result):
                self.products = result.data
                self.receiveData?()
            case let .failed(message):
                self.onErrorReceiveData?(message)
            }
        }
    }
    
    func didSelect(index: Int) {
        guard !products.isEmpty else {
            doSideEffect?("error")
            return
        }
        doSideEffect?("something crazy \(products[index].name)")
    }
}
