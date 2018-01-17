//
//  CCGenViewModel.swift
//  CreditCardGenerator
//
//  Created by Alexander Stolar on 16.01.2018.
//  Copyright © 2018 Alexander Stolar. All rights reserved.
//

import RxSwift

class CCGenViewModel {
    
    let bag = DisposeBag()
    
    var creditCardToValidate = BehaviorSubject<String>(value: "")
    var isCreditCardValid = BehaviorSubject<Bool>(value: false)
    var messageToAlert = PublishSubject<String>()
    
    init() {
        creditCardToValidate
            .filter { !($0.isEmpty) }
            .subscribe( onNext: { text in
                self.verifyCreditCard(data: text)
            }).disposed(by: bag)
    }
    
    private func verifyCreditCard(data: String) {
        CCGenNetworker.GET(with: data) { response in
            self.isCreditCardValid.onNext(response.successResponse != nil)
            
        }
    }
}
