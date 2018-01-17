//
//  CreditCard.swift
//  CreditCardGenerator
//
//  Created by Alexander Stolar on 16.01.2018.
//  Copyright © 2018 Alexander Stolar. All rights reserved.
//

import Foundation

class CreditCard {
    var bin: String
    var bank: String
    var card: String
    var type: String
    var level: String
    var country: String
    var countryCode: String
    var website: String
    var phone: String
    var valid: String
    
    init?(json: [String:AnyObject]) {
        guard let bin = json["bin"] as? String else { return nil }
        guard let bank = json["bank"] as? String else { return nil }
        guard let card = json["card"] as? String else { return nil }
        guard let type = json["type"] as? String else { return nil }
        guard let level = json["level"] as? String else { return nil }
        guard let country = json["country"] as? String else { return nil }
        guard let countryCode = json["countrycode"] as? String else { return nil }
        guard let website = json["website"] as? String else { return nil }
        guard let phone = json["phone"] as? String else { return nil }
        guard let valid = json["valid"] as? String else { return nil }
        
        self.bin = bin
        self.bank = bank
        self.card = card
        self.type = type
        self.level = level
        self.country = country
        self.countryCode = countryCode
        self.website = website
        self.phone = phone
        self.valid = valid
    }
}
