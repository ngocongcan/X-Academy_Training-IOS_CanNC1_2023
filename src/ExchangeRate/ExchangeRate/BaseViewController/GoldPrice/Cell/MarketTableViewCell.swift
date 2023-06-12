//
//  MarketTableViewCell.swift
//  ExchangeRate
//
//  Created by HanhNH11 on 08/06/2023.
//

import UIKit

class MarketTableViewCell: UITableViewCell {

    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var buyLabel: UILabel!
    @IBOutlet private weak var sellLabel: UILabel!
    
    func setupData(city: City) {
        updateCity(city: city.name)
        updateBuy(buy: city.items.first?.buy ?? "")
        updateSell(sell: city.items.first?.sell ?? "")
    }
}

private extension MarketTableViewCell {
    
    func updateCity(city: String) {
        self.cityLabel.text = city
    }
    
    func updateBuy(buy: String) {
        self.buyLabel.text = buy
    }
    
    func updateSell(sell: String) {
        self.sellLabel.text = sell
    }
}
