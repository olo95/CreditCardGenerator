//
//  UIResponder+Extension.swift
//  CreditCardGenerator
//
//  Created by Alexander Stolar on 16.01.2018.
//  Copyright © 2018 Alexander Stolar. All rights reserved.
//

import UIKit

extension UIResponder {
    
    static var typeName: String {
        return String(describing: self)
    }
}
