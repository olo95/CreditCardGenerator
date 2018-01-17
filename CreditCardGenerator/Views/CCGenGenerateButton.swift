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
    
    var isCrediCardValid = BehaviorSubject<Bool>(value: false)
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
        setTitle("Generate", for: .normal)
        
        bindUI()
    }
    
    private func bindUI() {
        isCrediCardValid.subscribe( onNext: { isCrediCardValid in
            self.isUserInteractionEnabled = isCrediCardValid
            self.tintColor = isCrediCardValid ? UIColor.blue : UIColor.gray
        }).disposed(by: bag)
    }
}
