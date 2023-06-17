//
//  ExchangeRateViewModel.swift
//  ExchangeRate
//
//  Created by HanhNH11 on 26/05/2023.
//

import Foundation

class ExchangeRateViewModel {
    
    var exchangeRatesService = ExchangeRatesService()
    var exchangeRateList: [ExchangeRate] = []
    
    func numberOfSections() -> Int {
        return exchangeRateList.count
    }
    
    func getExchangeRateList(completion: @escaping Completion) {
        exchangeRatesService.getExchangeRates(completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let lines):
                guard let lines = lines as? [String] else { return completion(.failure(nil)) }
                
                self.parserExchangeRateXML(xmlLines: lines)
                
                completion(.success)
                
            case .failure:
                completion(.failure(nil))
            }
        })
    }
}

private extension ExchangeRateViewModel {
    
    func parserExchangeRateXML(xmlLines: [String]) {
        
        for line in xmlLines {
            if line.contains("<Exrate") && !line.contains("<ExrateList") {
                let currencyCode = line.extractValue(forKey: "CurrencyCode")
                let currencyName = line.extractValue(forKey: "CurrencyName")
                let buyRate = line.extractValue(forKey: "Buy")
                let transferRate = line.extractValue(forKey: "Transfer")
                let sellRate = line.extractValue(forKey: "Sell")
                let exchangeRateList = ExchangeRate(currencyCode: currencyCode,
                                                    currencyName: currencyName,
                                                    buy: buyRate,
                                                    transfer: transferRate,
                                                    sell: sellRate)
                self.exchangeRateList.append(exchangeRateList)
            }
        }
    }
    
}

class ExchangeRatesServiceMock: ExchangeRatesService {
    func getExchangeRateListMock(completion: @escaping (ResultMock<[ExchangeRate], Error>) -> Void) {
        // Create a mock array of exchange rates
        exchangeRates = [
            ExchangeRate(currencyCode: "USD", currencyName: "USD", buy: "1.0", transfer: "1.0", sell: "1.0"),
            ExchangeRate(currencyCode: "EUR", currencyName: "EUR", buy: "2.0", transfer: "2.0", sell: "2.0"),
            ExchangeRate(currencyCode: "GBP", currencyName: "GBP", buy: "3.0", transfer: "3.0", sell: "3.0"),
        ]
        
        // Simulate an asynchronous call by using a DispatchQueue
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            completion(.success(self.exchangeRates))
        }
    }
}
