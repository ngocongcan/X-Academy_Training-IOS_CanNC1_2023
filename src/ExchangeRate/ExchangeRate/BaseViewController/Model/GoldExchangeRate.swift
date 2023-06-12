//
//  GoldExchangeRate.swift
//  ExchangeRate
//
//  Created by HanhNH11 on 07/06/2023.
//

import Foundation

struct Item {
    var buy: String
    var sell: String
    var type: String
}

struct City {
    var name: String
    var items: [Item]
}
