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
    var isValidLabel: UILabel!
    var isValid = BehaviorSubject<Bool>(value: false)
    
    func configure() {
        indicatorView = UIView()
        isValidLabel = UILabel()
        isValidLabel.textAlignment = .center
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        isValidLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(indicatorView)
        indicatorView.addSubview(isValidLabel)
        
        let centerXConstraint = NSLayoutConstraint(item: indicatorView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let centerYConstraint = NSLayoutConstraint(item: indicatorView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: indicatorView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.5, constant: 0.0)
        indicatorView.heightAnchor.constraint(equalTo: indicatorView.widthAnchor, multiplier: 1.0, constant: 0.0).isActive = true
        
        indicatorView.addConstraints([
            NSLayoutConstraint(item: isValidLabel, attribute: .top, relatedBy: .equal, toItem: indicatorView, attribute: .top, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: isValidLabel, attribute: .leading, relatedBy: .equal, toItem: indicatorView, attribute: .leading, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: isValidLabel, attribute: .bottom, relatedBy: .equal, toItem: indicatorView, attribute: .bottom, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: isValidLabel, attribute: .trailing, relatedBy: .equal, toItem: indicatorView, attribute: .trailing, multiplier: 1.0, constant: 0.0)
            ])
        
        indicatorView.backgroundColor = UIColor.red
        self.addConstraints([centerXConstraint, centerYConstraint, widthConstraint])
        indicatorView.layer.cornerRadius = 8
        
        bindUI()
    }
    
    private func bindUI() {
        isValid.subscribe( onNext: { isValid in
            DispatchQueue.main.async {
                self.indicatorView.backgroundColor = isValid ? UIColor.green : UIColor.red
                self.isValidLabel.text = isValid ? "Valid" : "Not valid"
            }
        }).disposed(by: bag)
    }
}
