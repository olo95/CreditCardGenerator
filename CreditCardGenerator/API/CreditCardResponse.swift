//
//  CreditCardResponse.swift
//  CreditCardGenerator
//
//  Created by Alexander Stolar on 17.01.2018.
//  Copyright © 2018 Alexander Stolar. All rights reserved.
//

import Foundation

class CreditCardErrorResponse {
    var error: String
    var message: String
    
    init?(json: [String:AnyObject]) {
        guard let error = json["error"] as? String else { return nil }
        guard let message = json["message"] as? String else { return nil }
        self.error = error
        self.message = message
    }
}

struct CreditCardResponse {
    var errorResponse: CreditCardErrorResponse?
    var successResponse: CreditCard?
}
