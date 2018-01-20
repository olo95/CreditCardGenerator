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
    var beforeNextChangeLength = 0
    
    func configure() {
        backgroundColor = UIColor.white
        placeholder = "XXXX XXXX XXXX XXXX XX/XX XXX"
        translatesAutoresizingMaskIntoConstraints = false
        textAlignment = .center
        
        rx.value.subscribe( onNext: { value in
            guard let value = value else {
                return
            }
            
            guard var text = self.text else {
                return
            }
            
            guard value.count > self.beforeNextChangeLength else {
                self.beforeNextChangeLength = text.count
                return
            }
            
            if value.count == ConstantsCreditCard.length + 1 {
                text.removeLast()
                self.text = text
                self.beforeNextChangeLength = text.count
                return
            }
            
            if ConstantsCreditCard.backslash.index == value.count - 1 {
                text.removeLast()
                text.append("\(ConstantsCreditCard.backslash.char)\(value.last!)")
                self.text = text
                self.beforeNextChangeLength = text.count
                return
            }
            
            if ConstantsCreditCard.spaceIndexes.contains(value.count - 1) {
                text.removeLast()
                text.append(" \(value.last!)")
                self.text = text
                self.beforeNextChangeLength = text.count
                return
            }
        }).disposed(by: bag)
    }
}
