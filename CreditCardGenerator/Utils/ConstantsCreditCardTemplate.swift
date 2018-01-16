//
//  ConstantsCreditCardTemplate.swift
//  CreditCardGenerator
//
//  Created by Alexander Stolar on 17.01.2018.
//  Copyright © 2018 Alexander Stolar. All rights reserved.
//

struct ConstantsCreditCardTemplate {
    static let creditCardNumber: CountableRange<Int> = 0..<19
    static let creditCardDate: CountableRange<Int> = 19..<25
    static let creditCardCvc: CountableRange<Int> = 25..<ConstantsCreditCard.length
}
