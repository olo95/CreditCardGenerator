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
    
    func testCreditCardGenerationMethods() {
        for _ in 0 ..< 100000 {
            guard let _ = CCGenRandomNumberManager.default.generateNumberSequenceWithoutLuhnDigit(), let _ = CCGenRandomNumberManager.default.generateRandomCreditCard() else {
                XCTFail("Number generation failure")
                return
            }
        }
    }
    
    func testLuhnDigitComputation() {
        for _ in 0 ..< 100000 {
            guard let randomCC = CCGenRandomNumberManager.default.generateRandomCreditCard() else {
                XCTFail("Number generation failure")
                return
            }
            guard let randomCCAsInt = Int(randomCC) else {
                XCTFail("Random CC Int cast error")
                return
            }
            let luhnDigit = CCGenRandomNumberManager.default.calculateLuhnDigit(basedOn: randomCCAsInt)
            if luhnDigit != 0 {
                XCTFail()
            }
        }
    }
    
    func testLengthRandomCreditCards() {
        for _ in 0 ..< 100000 {
            guard let randomCC = CCGenRandomNumberManager.default.generateRandomCreditCard() else {
                XCTFail("Number generation failure")
                return
            }
            if randomCC.count != ConstantsCreditCard.numbersCount {
                XCTFail()
                return
            }
        }
    }
    
    func testCreditCardIntCast() {
        for _ in 0 ..< 100000 {
            guard let randomCcWithoutLuhnDigit = CCGenRandomNumberManager.default.generateNumberSequenceWithoutLuhnDigit() else {
                XCTFail("Number generation failure")
                return
            }
            guard let randomCC = CCGenRandomNumberManager.default.generateRandomCreditCard() else {
                XCTFail("Number generation failure")
                return
            }
            guard Int(randomCcWithoutLuhnDigit) != nil, Int(randomCC) != nil else {
                XCTFail()
                return
            }
        }
    }
    
    func testCreatingURL() {
        for _ in 0 ..< 100000 {
            guard let randomCC = CCGenRandomNumberManager.default.generateRandomCreditCard() else {
                XCTFail("Number generation failure")
                return
            }
            
            guard let _ = CCGenNetworker.default.createURL(with: randomCC) else {
                XCTFail("URL generation failed")
                return
            }
        }
    }
    
    func testSuccessCodeAPIResponse() {
        let expect = expectation(description: "GET")
        CCGenNetworker.default.GET(with: "4976603425924902") { (data, response, error) in
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                XCTFail("Success response bad status code")
                expect.fulfill()
                return
            }
            XCTAssert(true)
            expect.fulfill()
        }
        waitForExpectations(timeout: 5.0) { _ in
            print("Server timeout")
        }
    }
    
    func testFailureCodeAPIResponse() {
        let expect = expectation(description: "GET")
        CCGenNetworker.default.GET(with: "4976603425924901") { (data, response, error) in
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode < 200 && statusCode > 299 else {
                XCTFail("Failure response bad status code")
                expect.fulfill()
                return
            }
            expect.fulfill()
        }
        waitForExpectations(timeout: 5.0) { _ in
            print("Server timeout")
        }
    }
}
