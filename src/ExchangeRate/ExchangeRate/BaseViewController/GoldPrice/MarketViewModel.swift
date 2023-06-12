//
//  MarketViewModel.swift
//  ExchangeRate
//
//  Created by HanhNH11 on 07/06/2023.
//

import Foundation
class MarketViewModel {
    let exchangeRatesService = ExchangeRatesService()
    var cities: [City] = []
    var loadingStatusDidChange: ((Bool) -> Void)?
    
    func numberOfSections() -> Int {
        return cities.count
    }
    
    func getGoldExchangeRateList(completion: @escaping Completion) {
        self.loadingStatusDidChange?(true)
        exchangeRatesService.getDataXML(urlString: "https://sjc.com.vn/xml/tygiavang.xml") { [weak self] result in
            guard let self = self else {
                completion(.failure(nil))
                return
            }
            self.loadingStatusDidChange?(false)
            switch result {
            case .success(let lines):
                var currentCity: String?
                var currentBuyPrice: String = ""
                var currentSellPrice: String = ""
                var currentType: String = ""
                guard let lines = lines as? [String] else {
                    completion(.failure(nil))
                    return
                }
                for line in lines {
                    if line.contains("<city name=") {
                        currentCity = line.extractValue(forKey: "name")
                    } else if line.contains("<item") {
                        currentBuyPrice = line.extractValue(forKey: "buy")
                        currentSellPrice = line.extractValue(forKey: "sell")
                        currentType = line.extractValue(forKey: "type")
                        if let city = currentCity {
                            let city = City(name: city, items: [Item(buy: currentBuyPrice, sell: currentSellPrice, type: currentType)])
                            self.cities.append(city)
                        }
                    }
                }
                completion(.success)
            case .failure:
                completion(.failure(nil))
            }
        }
    }
}
