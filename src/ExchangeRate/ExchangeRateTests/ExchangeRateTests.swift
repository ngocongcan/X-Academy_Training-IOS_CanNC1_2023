//
//  ExchangeRateTests.swift
//  ExchangeRateTests
//
//  Created by HanhNH11 on 05/06/2023.
//

import XCTest
@testable import ExchangeRate

final class ExchangeRateTests: XCTestCase {
    
    var viewModel: ExchangeRateViewModel!
    var exchangeRatesServiceMock: ExchangeRatesServiceMock!
    
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testExample() throws {}

    func testPerformanceExample() throws {
        self.measure {}
    }
    
    override func setUp() {
        super.setUp()
        setupTests()
    }
    
    func setupTests() {
        testGetExchangeRateListSuccessful()
        testNumberOfSections()
    }
    
    override func tearDown() {
        viewModel = nil
        exchangeRatesServiceMock = nil
        super.tearDown()
    }
    
    func testGetExchangeRateListSuccessful() {
        // Create an instance of the ExchangeRateViewModel
        let viewModel = ExchangeRateViewModel()
        
        // Create an instance of the ExchangeRatesServiceMock
        let exchangeRatesServiceMock = ExchangeRatesServiceMock()
        
        // Set the exchangeRatesService of the viewModel to the mock service
        viewModel.exchangeRatesService = exchangeRatesServiceMock
            
        // Create an expectation for the async operation
        let expectation = XCTestExpectation(description: "Get exchange rate list successful")
        
        // Call the getExchangeRateList method
        exchangeRatesServiceMock.getExchangeRateListMock { result in
            switch result {
            case .success:
                // Check if the exchangeRateList has been updated
                XCTAssertEqual(exchangeRatesServiceMock.exchangeRates.count, 3)
                
                // Perform additional assertions on the exchangeRateList if needed
                
                // Fulfill the expectation
                expectation.fulfill()
                
            case .failure:
                XCTFail("Unexpected failure")
            }
        }
        
        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testNumberOfSections() {
           let viewModel = ExchangeRateViewModel()
           
           viewModel.exchangeRateList = [
             ExchangeRate(currencyCode: "USD", currencyName: "USD", buy: "1.0", transfer: "1.0", sell: "1.0"),
             ExchangeRate(currencyCode: "EUR", currencyName: "EUR", buy: "2.0", transfer: "2.0", sell: "2.0"),
             ExchangeRate(currencyCode: "GBP", currencyName: "GBP", buy: "3.0", transfer: "3.0", sell: "3.0"),
           ]
           
           XCTAssertEqual(viewModel.numberOfSections(), 3)
       }
}
