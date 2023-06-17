//
//  ExchangeRatesService.swift
//  ExchangeRate
//
//  Created by HanhNH11 on 07/06/2023.
//

import Foundation

protocol ExchangeRatesServiceType {
    func getExchangeRates(completion: @escaping APICompletion)
}

class ExchangeRatesService: ExchangeRatesServiceType {
    
    let ExchangeRatesEndpoint = "https://portal.vietcombank.com.vn/Usercontrols/TVPortal.TyGia/pXML.aspx"
    
    var exchangeRates: [ExchangeRate] = []
    
    func getExchangeRates(completion: @escaping APICompletion) {
        return self.getDataXML(urlString: self.ExchangeRatesEndpoint, completion: completion)
    }
    
}

extension ExchangeRatesService: XMLDataServiceType {
    // using default implementation of the method getDataXML
    // in case of override the implementation, need to do here
}
