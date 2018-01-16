//
//  CreditCard.swift
//  CreditCardGenerator
//
//  Created by Alexander Stolar on 16.01.2018.
//  Copyright © 2018 Alexander Stolar. All rights reserved.
//

import Foundation

struct CreditCardTemplate {
    let creditCardNumber: CountableRange<Int> = 0..<19
    let creditCardDate: CountableRange<Int> = 19..<25
    let creditCardCvc: CountableRange<Int> = 25..<30
}

class CreditCard {
    
}
