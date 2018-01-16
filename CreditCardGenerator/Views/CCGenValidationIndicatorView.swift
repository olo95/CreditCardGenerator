//
//  CCGenValidationIndicatorView.swift
//  CreditCardGenerator
//
//  Created by Alexander Stolar on 16.01.2018.
//  Copyright © 2018 Alexander Stolar. All rights reserved.
//

import UIKit

class CCGenValidationIndicatorView: UIView {
    
    func configure() {
        layer.cornerRadius = frame.width / 2
        backgroundColor = UIColor.red
    }
}
