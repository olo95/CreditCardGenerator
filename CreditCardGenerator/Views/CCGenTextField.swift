//
//  CCGenTextField.swift
//  CreditCardGenerator
//
//  Created by Alexander Stolar on 16.01.2018.
//  Copyright © 2018 Alexander Stolar. All rights reserved.
//

import RxSwift
import RxCocoa

class CCGenTextField: UITextField {
    
    let bag = DisposeBag()
    
    func configure() {
        backgroundColor = UIColor.white
        
        rx.value.subscribe( onNext: { value in
            guard let value = value else {
                return
            }
            
            guard var text = self.text else {
                return
            }
            
            if text.count == CreditCardTemplate.length {
                text.removeLast()
                self.text = text
                return
            }
            
            if CreditCardTemplate.spaceIndexes.contains(text.count - 1) {
                text.removeLast()
                text.append(" \(value.last!)")
                self.text = text
            }
        }).disposed(by: bag)
    }
}
