//
//  CCGenGenerateButton.swift
//  CreditCardGenerator
//
//  Created by Alexander Stolar on 16.01.2018.
//  Copyright © 2018 Alexander Stolar. All rights reserved.
//

import UIKit

class CCGenGenerateButton: UIButton {
    
    func configure() {
        isUserInteractionEnabled = true
        setTitle("Generate", for: .normal)
    }
}
