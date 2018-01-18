//
//  CCGenRandomNumberManager.swift
//  CreditCardGenerator
//
//  Created by Alexander Stolar on 17.01.2018.
//  Copyright © 2018 Alexander Stolar. All rights reserved.
//

import Foundation

enum CreditCardType: UInt32 {
    case masterCard = 0
    case visa = 1
}

class CCGenRandomNumberManager {
    
    static func generateRandomCreditCard() -> String {
        let creditCardType = CreditCardType(rawValue: arc4random_uniform(2))
        var inn: UInt32
        
        switch creditCardType! {
        case .masterCard:
            inn = 51 + arc4random_uniform(5)
        case .visa:
            inn = 4
        default:
            break
        }
        
        let numberOfRemainingDigits = 15 - String(inn).count
        var remainingNumbers: String = ""
        
        for _ in 0..<numberOfRemainingDigits {
            remainingNumbers += String(arc4random_uniform(10))
        }
        
        var creditCardWithoutLuhnDigit = String(inn) + remainingNumbers
        
        return creditCardWithoutLuhnDigit + String(calculateLuhnDigit(basedOn: Int(creditCardWithoutLuhnDigit)!))
    }
    
    private static func calculateLuhnDigit(basedOn number: Int) -> Int {
        
        let sequence = String(number).map { Int(String($0))! }
        let sequenceOfSingleDigits = sequence
            .enumerated()
            .map { index, element in
                return element * (index % 2 == 0 ? 2 : 1)
            }
            .map { return String($0).map { Int(String($0))! } }
        
        let sequenceOfSummedDigits = sequenceOfSingleDigits.map { return $0.reduce(0, +) }
        let modTen = sequenceOfSummedDigits.reduce(0, +) % 10
        
        return 10 - modTen
    }
}
