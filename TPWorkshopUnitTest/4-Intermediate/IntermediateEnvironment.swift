//
//  IntermediateEnvironment.swift
//  TPWorkshopUnitTest
//
//  Created by digital.aurum on 24/11/21.
//

import Foundation

struct IntermediateEnvironment {
    static var loadTickerCache: ((String) -> Ticker?) = { key -> Ticker? in
        if let data = UserDefaults.standard.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            return try? decoder.decode(Ticker.self, from: data)
        }
        return nil
    }

    static var saveTickerCache: ((Ticker, String) -> Void) = { value, key in
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(value) {
            UserDefaults.standard.set(encodedData, forKey: key)
        }
    }
}
