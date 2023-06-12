//
//  ExchangeRateTableViewCell.swift
//  exchange_rate_demo
//
//  Created by HanhNH11 on 26/05/2023.
//

import UIKit

class ExchangeRateTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var currencyNameLabel: UILabel!
    @IBOutlet private weak var buyLabel: UILabel!
    @IBOutlet private weak var currencyCodeLabel: UILabel!
    @IBOutlet private weak var sellLabel: UILabel!
    @IBOutlet private weak var flagImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.flagImageView.layer.cornerRadius = flagImageView.frame.width / 2
    }

    func setupData(exchangeRate: ExchangeRate) {
        updateCurrencyCode(currencyCode: exchangeRate.currencyCode)
        exchangeRateName(currencyName: exchangeRate.currencyName)
        updateBuy(buyExchangeRate: exchangeRate.buy)
        updateSell(sellExchangeRate: exchangeRate.sell)
    }
}

private extension ExchangeRateTableViewCell {
    
    func updateCurrencyCode(currencyCode: String) {
        self.currencyCodeLabel.text = currencyCode
    }
    
    func exchangeRateName(currencyName: String) {
        self.currencyNameLabel.text = currencyName
    }
    
    func updateBuy(buyExchangeRate: String) {
        self.buyLabel.text = buyExchangeRate
    }
    
    func updateSell(sellExchangeRate: String) {
        self.sellLabel.text = sellExchangeRate
    }
}
