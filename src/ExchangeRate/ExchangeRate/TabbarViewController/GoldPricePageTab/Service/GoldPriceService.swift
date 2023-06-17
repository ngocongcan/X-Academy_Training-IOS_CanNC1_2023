//
//  GoldPriceService.swift
//  ExchangeRate
//
//  Created by HanhNH11 on 07/06/2023.
//

import Foundation

protocol GoldPriceServiceType {
    func getGoldPrice(completion: @escaping APICompletion)
}

class GoldPriceService: GoldPriceServiceType {

    let GoldPriceEndpoint = "https://sjc.com.vn/xml/tygiavang.xml"
    
    func getGoldPrice(completion: @escaping APICompletion) {
        return self.getDataXML(urlString: self.GoldPriceEndpoint, completion: completion)
    }

}

extension GoldPriceService: XMLDataServiceType {
    // using default implementation of the method getDataXML
    // in case of override the implementation, need to do here
}
