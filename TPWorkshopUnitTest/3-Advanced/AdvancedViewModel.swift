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
        var productResult = [Product]()
        var errorMessage: String = ""
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        useCase.fetchProduct { result in
            switch result {
            case let .success(productData):
                productResult = productData.data
            case let .failed(message):
                errorMessage = message
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            if errorMessage.isEmpty {
                self.products = productResult
                self.receiveData?()
            } else {
                self.onErrorReceiveData?(errorMessage)
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
