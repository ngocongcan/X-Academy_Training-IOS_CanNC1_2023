//
//  ApiManager.swift
//  ExchangeRate
//
//  Created by HanhNH11 on 07/06/2023.
//

import Foundation

typealias APICompletion = (APIResult) -> Void
typealias Completion = (Result) -> Void

enum APIResult {
    case success(Any?)
    case failure(String?)
}

enum Result {
    case success
    case failure(String?)
}

enum ResultMock<T, E: Error> {
    case success(T)
    case failure(E)
}
