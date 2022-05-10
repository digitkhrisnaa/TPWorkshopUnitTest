//
//  Ticker.swift
//  TPWorkshopUnitTest
//
//  Created by digital.aurum on 24/11/21.
//

import Foundation

struct Ticker: Codable, Equatable, HashDiffable {
    let id: Int
    let title: String
    
    var identifier: Int {
        return "ticker-\(id)".hashValue
    }
}
