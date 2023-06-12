//
//  StringExtension.swift
//  ExchangeRate
//
//  Created by HanhNH11 on 09/06/2023.
//

import Foundation
extension String {
    func extractValue(forKey key: String) -> String {
        guard let keyRange = self.range(of: "\(key)=\"") else {
            return ""
        }
        
        let startIndex = keyRange.upperBound
        let endIndex = self.range(of: "\"", range: startIndex..<self.endIndex)?.lowerBound
        
        if let endIndex = endIndex {
            return String(self[startIndex..<endIndex])
        }
        return ""
    }
}
