//
//  CCGenRandomNumberManager.swift
//  CreditCardGenerator
//
//  Created by Alexander Stolar on 17.01.2018.
//  Copyright © 2018 Alexander Stolar. All rights reserved.
//

import Foundation

class CCGenRandomNumberManager {
    
    static func generateRandomCreditCard() -> String {
        var type = arc4random_uniform(2)
        var inn = type % 2 ? 
        
        return ""
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
