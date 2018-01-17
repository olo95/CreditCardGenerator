//
//  CCGenValidationIndicatorView.swift
//  CreditCardGenerator
//
//  Created by Alexander Stolar on 16.01.2018.
//  Copyright © 2018 Alexander Stolar. All rights reserved.
//

import RxSwift
import RxCocoa

class CCGenValidationIndicatorView: UIView {
    
    let bag = DisposeBag()
    
    var indicatorView: UIView!
    var isValid = BehaviorSubject<Bool>(value: false)
    
    func configure() {
        indicatorView = UIView()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(indicatorView)
        
        let centerXConstraint = NSLayoutConstraint(item: indicatorView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let centerYConstraint = NSLayoutConstraint(item: indicatorView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: indicatorView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.5, constant: 0.0)
        indicatorView.heightAnchor.constraint(equalTo: indicatorView.widthAnchor, multiplier: 1.0, constant: 0.0).isActive = true
        
        indicatorView.backgroundColor = UIColor.red
        self.addConstraints([centerXConstraint, centerYConstraint, widthConstraint])
        indicatorView.layer.cornerRadius = 8
    }
    
    private func bindUI() {
        isValid.subscribe( onNext: { isValid in
            self.indicatorView.backgroundColor = isValid ? UIColor.green : UIColor.blue
        }).disposed(by: bag)
    }
}
