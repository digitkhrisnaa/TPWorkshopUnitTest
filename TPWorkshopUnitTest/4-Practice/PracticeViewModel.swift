//
//  PracticeViewModel.swift
//  TPWorkshopUnitTest
//
//  Created by digital.aurum on 23/11/21.
//

import Foundation

class PracticeViewModel {
    var data: [HashDiffable] = []
    let useCase: PracticeNetworkProvider
    var timerProvider: Timer.Type?
    
    init(useCase: PracticeNetworkProvider, timerProvider: Timer.Type = Timer.self) {
        self.useCase = useCase
        self.timerProvider = timerProvider
    }
    
    // MARK: Output
    var didReceiveData: (() -> Void)?
    var didGotError: (([String]) -> Void)?
    var hasTicker: ((Bool) -> Void)?
    
    // MARK: Input
    func onDidLoad() {
        var productResult: ProductResult?
        var inspirationResult: InspirationResult?
        var tickerResult: Ticker?
        var errorMessage: [String] = []
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        useCase.fetchProduct { networkResult in
            switch networkResult {
            case let .success(product):
                productResult = product
            case let .failed(message):
                errorMessage.append(message)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        useCase.fetchInspiration { networkResult in
            switch networkResult {
            case let .success(inspiration):
                inspirationResult = inspiration
            case let .failed(message):
                errorMessage.append(message)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        useCase.fetchTicker { networkResult in
            switch networkResult {
            case let .success(ticker):
                tickerResult = ticker
            case let .failed(message):
                errorMessage.append(message)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            if errorMessage.isEmpty || productResult != nil {
                self.processor(product: productResult, inspiration: inspirationResult, ticker: tickerResult)
            } else {
                self.didGotError?(errorMessage)
            }
        }
    }
    
    func onFireDate() {
        timerProvider?.scheduledTimer(withTimeInterval: 5, repeats: false, block: { [weak self] timer in
            guard let self = self, let tickerData = PracticeEnvironment.loadTickerCache("tickerData") else {
                return
            }
            
            self.data.insert(tickerData, at: 0)
            self.didReceiveData?()
            timer.invalidate()
        })
    }
    
    deinit {
        self.timerProvider = nil
    }
    
    // MARK: Private methods
    private func processor(product: ProductResult?, inspiration: InspirationResult?, ticker: Ticker?) {
        guard let products = product?.data else {
            return
        }
        
        var mutableProducts: [HashDiffable] = products
        
        if let ticker = ticker {
            PracticeEnvironment.saveTickerCache(ticker, "tickerData")
            hasTicker?(true)
        } else {
            hasTicker?(false)
        }
        
        if let inspirationData = inspiration?.data {
            var counter = 0
            inspirationData.forEach { value in
                if value.position + counter > products.count {
                    return
                } else {
                    mutableProducts.insert(value, at: value.position + counter)
                    counter += 1
                }
            }
        }
        
        data = mutableProducts
        didReceiveData?()
    }
}
