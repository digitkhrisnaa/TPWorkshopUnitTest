//
//  4-MockData.swift
//  TPWorkshopUnitTestTests
//
//  Created by digital.aurum on 24/11/21.
//

@testable import TPWorkshopUnitTest

struct Mock4PositiveWorkshopProvider: IntermediateNetworkProvider {
    func fetchProduct(onComplete: @escaping (NetworkResult<ProductResult>) -> Void) {
        onComplete(.success(Mock4ProductData.generateProductResult()))
    }
    
    func fetchInspiration(onComplete: @escaping (NetworkResult<InspirationResult>) -> Void) {
        onComplete(.success(Mock4ProductData.generateInspirationResult()))
    }
    
    func fetchTicker(onComplete: @escaping (NetworkResult<Ticker>) -> Void) {
        onComplete(.success(Mock4ProductData.generateTicker()))
    }
}

struct Mock4NegativeProductWorkshopProvider: IntermediateNetworkProvider {
    func fetchProduct(onComplete: @escaping (NetworkResult<ProductResult>) -> Void) {
        onComplete(.failed("failed fetch product"))
    }
    
    func fetchInspiration(onComplete: @escaping (NetworkResult<InspirationResult>) -> Void) {
        onComplete(.success(Mock4ProductData.generateInspirationResult()))
    }
    
    func fetchTicker(onComplete: @escaping (NetworkResult<Ticker>) -> Void) {
        onComplete(.success(Mock4ProductData.generateTicker()))
    }
}

struct Mock4NegativeInspirationWorkshopProvider: IntermediateNetworkProvider {
    func fetchProduct(onComplete: @escaping (NetworkResult<ProductResult>) -> Void) {
        onComplete(.success(Mock4ProductData.generateProductResult()))
    }
    
    func fetchInspiration(onComplete: @escaping (NetworkResult<InspirationResult>) -> Void) {
        onComplete(.failed("failed fetch inspiration"))
    }
    
    func fetchTicker(onComplete: @escaping (NetworkResult<Ticker>) -> Void) {
        onComplete(.success(Mock4ProductData.generateTicker()))
    }
}

struct Mock4NegativeTickerWorkshopProvider: IntermediateNetworkProvider {
    func fetchProduct(onComplete: @escaping (NetworkResult<ProductResult>) -> Void) {
        onComplete(.success(Mock4ProductData.generateProductResult()))
    }
    
    func fetchInspiration(onComplete: @escaping (NetworkResult<InspirationResult>) -> Void) {
        onComplete(.success(Mock4ProductData.generateInspirationResult()))
    }
    
    func fetchTicker(onComplete: @escaping (NetworkResult<Ticker>) -> Void) {
        onComplete(.failed("failed fetch ticker"))
    }
}

struct Mock4NegativeAllWorkshopProvider: IntermediateNetworkProvider {
    func fetchProduct(onComplete: @escaping (NetworkResult<ProductResult>) -> Void) {
        onComplete(.failed("failed fetch product"))
    }
    
    func fetchInspiration(onComplete: @escaping (NetworkResult<InspirationResult>) -> Void) {
        onComplete(.failed("failed fetch inspiration"))
    }
    
    func fetchTicker(onComplete: @escaping (NetworkResult<Ticker>) -> Void) {
        onComplete(.failed("failed fetch ticker"))
    }
}

struct Mock4ProductData {
    static func generateProductResult() -> ProductResult {
        var products: [Product] = []
        for i in 1 ..< 5 {
            let product = Product(id: i,
                                  name: "lorem ipsum",
                                  imageURL: nil,
                                  price: "Rp 100",
                                  shop: Shop(id: 1,
                                             name: "toko serba ada",
                                             location: "Indonesia"))
            products.append(product)
        }
        return ProductResult(data: products)
    }
    
    static func generateInspirationResult() -> InspirationResult {
        var products: [ProductInspiration] = []
        for i in 1 ..< 2 {
            let productInspiration = ProductInspiration(id: i, price: 10000, imageURL: nil)
            products.append(productInspiration)
        }
        
        var inspirations: [Inspiration] = []
        for i in 1 ..< 3 {
            let inspiration = Inspiration(title: "lorem\(i)", position: i, products: products)
            inspirations.append(inspiration)
        }
        
        return InspirationResult(data: inspirations)
    }
    
    static func generateTicker() -> Ticker {
        return Ticker(id: 1, title: "belanja yuk")
    }
    
    static func generateExpectedCompleteValue() -> [HashDiffable] {
        [
            Product(id: 1,
                    name: "lorem ipsum",
                    imageURL: nil,
                    price: "Rp 100",
                    shop: Shop(id: 1,
                               name: "toko serba ada",
                               location: "Indonesia")),
            Inspiration(title: "lorem\(1)",
                        position: 1,
                        products: [ProductInspiration(id: 1, price: 10000, imageURL: nil)]),
            Product(id: 2,
                    name: "lorem ipsum",
                    imageURL: nil,
                    price: "Rp 100",
                    shop: Shop(id: 1,
                               name: "toko serba ada",
                               location: "Indonesia")),
            Inspiration(title: "lorem\(2)",
                        position: 2,
                        products: [ProductInspiration(id: 1, price: 10000, imageURL: nil)]),
            Product(id: 3,
                    name: "lorem ipsum",
                    imageURL: nil,
                    price: "Rp 100",
                    shop: Shop(id: 1,
                               name: "toko serba ada",
                               location: "Indonesia")),
            Product(id: 4,
                    name: "lorem ipsum",
                    imageURL: nil,
                    price: "Rp 100",
                    shop: Shop(id: 1,
                               name: "toko serba ada",
                               location: "Indonesia"))
            
        ]
    }
    
    static func generateExpectedWithoutInspirationValue() -> [HashDiffable] {
        [
            Product(id: 1,
                    name: "lorem ipsum",
                    imageURL: nil,
                    price: "Rp 100",
                    shop: Shop(id: 1,
                               name: "toko serba ada",
                               location: "Indonesia")),
            Product(id: 2,
                    name: "lorem ipsum",
                    imageURL: nil,
                    price: "Rp 100",
                    shop: Shop(id: 1,
                               name: "toko serba ada",
                               location: "Indonesia")),
            Product(id: 3,
                    name: "lorem ipsum",
                    imageURL: nil,
                    price: "Rp 100",
                    shop: Shop(id: 1,
                               name: "toko serba ada",
                               location: "Indonesia")),
            Product(id: 4,
                    name: "lorem ipsum",
                    imageURL: nil,
                    price: "Rp 100",
                    shop: Shop(id: 1,
                               name: "toko serba ada",
                               location: "Indonesia"))
            
        ]
    }
    
    static func generateExpectedCompleteValueWithTicker() -> [HashDiffable] {
        [
            Ticker(id: 1, title: "belanja yuk"),
            Product(id: 1,
                    name: "lorem ipsum",
                    imageURL: nil,
                    price: "Rp 100",
                    shop: Shop(id: 1,
                               name: "toko serba ada",
                               location: "Indonesia")),
            Inspiration(title: "lorem\(1)",
                        position: 1,
                        products: [ProductInspiration(id: 1, price: 10000, imageURL: nil)]),
            Product(id: 2,
                    name: "lorem ipsum",
                    imageURL: nil,
                    price: "Rp 100",
                    shop: Shop(id: 1,
                               name: "toko serba ada",
                               location: "Indonesia")),
            Inspiration(title: "lorem\(2)",
                        position: 2,
                        products: [ProductInspiration(id: 1, price: 10000, imageURL: nil)]),
            Product(id: 3,
                    name: "lorem ipsum",
                    imageURL: nil,
                    price: "Rp 100",
                    shop: Shop(id: 1,
                               name: "toko serba ada",
                               location: "Indonesia")),
            Product(id: 4,
                    name: "lorem ipsum",
                    imageURL: nil,
                    price: "Rp 100",
                    shop: Shop(id: 1,
                               name: "toko serba ada",
                               location: "Indonesia"))
            
        ]
    }
}
