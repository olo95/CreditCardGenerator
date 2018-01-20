//
//  CreditCardGeneratorTests.swift
//  CreditCardGeneratorTests
//
//  Created by Alexander Stolar on 16.01.2018.
//  Copyright © 2018 Alexander Stolar. All rights reserved.
//

import XCTest
@testable import CreditCardGenerator

class CreditCardGeneratorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testLuhnDigitComputation() {
        for _ in 0 ..< 100000 {
            let randomCC = CCGenRandomNumberManager.default.generateRandomCreditCard()
            let luhnDigit = CCGenRandomNumberManager.default.calculateLuhnDigit(basedOn: Int(randomCC)!)
            if luhnDigit != 0 {
                XCTFail()
            }
        }
    }
    
    func testLengthRandomCreditCards() {
        for _ in 0 ..< 100000 {
            let randomCC = CCGenRandomNumberManager.default.generateRandomCreditCard()
            if randomCC.count != ConstantsCreditCard.numbersCount {
                XCTFail()
            }
        }
    }
}
