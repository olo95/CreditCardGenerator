//
//  String+Extension.swift
//  CreditCardGenerator
//
//  Created by Alexander Stolar on 17.01.2018.
//  Copyright © 2018 Alexander Stolar. All rights reserved.
//

extension String {
    
    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
}
