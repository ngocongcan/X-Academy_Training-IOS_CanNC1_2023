//
//  GoldPriceViewModel.swift
//  ExchangeRate
//
//  Created by HanhNH11 on 07/06/2023.
//

import Foundation

class GoldPriceViewModel {
    
    let goldPriceService = GoldPriceService()
    var cities: [GoldPriceCity] = []
    var loadingStatusDidChange: ((Bool) -> Void)?
    
    func numberOfSections() -> Int {
        return cities.count
    }
    
    func getGoldPrice(completion: @escaping Completion) {
        self.loadingStatusDidChange?(true)
        
        goldPriceService.getGoldPrice {  [weak self] result in
            guard let self = self else {
                completion(.failure(nil))
                return
            }
            self.loadingStatusDidChange?(false)
            switch result {
            case .success(let lines):
                guard let lines = lines as? [String] else {
                    completion(.failure(nil))
                    return
                }
                
                self.parserGoldPriceXML(xmlLines: lines)
                
                completion(.success)
            case .failure:
                completion(.failure(nil))
            }
        }
    }
}

private extension GoldPriceViewModel {
    
    func parserGoldPriceXML(xmlLines: [String]) {
        
        var currentCity: String?
        var currentBuyPrice: String = ""
        var currentSellPrice: String = ""
        var currentType: String = ""
        
        for line in xmlLines {
            if line.contains("<city name=") {
                currentCity = line.extractValue(forKey: "name")
            } else if line.contains("<item") {
                currentBuyPrice = line.extractValue(forKey: "buy")
                currentSellPrice = line.extractValue(forKey: "sell")
                currentType = line.extractValue(forKey: "type")
                if let city = currentCity {
                    let city = GoldPriceCity(name: city, items: [GoldPriceItem(buy: currentBuyPrice, sell: currentSellPrice, type: currentType)])
                    self.cities.append(city)
                }
            }
        }
    }
}
