//
//  UIColor.swift
//  ExchangeRate
//
//  Created by HanhNH11 on 07/06/2023.
//

import Foundation
import UIKit

extension UIColor {
    static func rgb(_ red: Int, _ green: Int, _ blue: Int, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
}
