//
//  ExchangeRatesService.swift
//  ExchangeRate
//
//  Created by HanhNH11 on 07/06/2023.
//

import Foundation
class ExchangeRatesService {

    var exchangeRates: [ExchangeRate] = []

    func getDataXML(urlString: String, completion: @escaping APICompletion) {
        guard let url = URL(string: urlString) else {
            completion(.failure("Lỗi URL"))
            return
        }
    
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error.localizedDescription))
                return
            }

            guard let data = data else {
                completion(.failure("Dữ liệu trống"))
                return
            }

            if let xmlString = String(data: data, encoding: .utf8) {
                let lines = xmlString.components(separatedBy: .newlines)
                completion(.success(lines))
            }
        }
        task.resume()
    }
}
