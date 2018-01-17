//
//  CCGenGenerateButton.swift
//  CreditCardGenerator
//
//  Created by Alexander Stolar on 16.01.2018.
//  Copyright © 2018 Alexander Stolar. All rights reserved.
//

import RxSwift
import RxCocoa

class CCGenGenerateButton: UIButton {
    
    let bag = DisposeBag()
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        setTitle("Generate", for: .normal)
        
        bindUI()
    }
    
    private func bindUI() {
        
    }
}
