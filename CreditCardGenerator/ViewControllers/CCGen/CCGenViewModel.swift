//
//  CCGenViewModel.swift
//  CreditCardGenerator
//
//  Created by Alexander Stolar on 16.01.2018.
//  Copyright © 2018 Alexander Stolar. All rights reserved.
//

import RxSwift

enum RequestProcessStatus {
    case noRequest, failure, progress, success
}

class CCGenViewModel {
    let bag = DisposeBag()
    
    var creditCardToValidate = BehaviorSubject<String>(value: "")
    var requestProcessStatus = BehaviorSubject<RequestProcessStatus>(value: .noRequest)
    var messageToAlert = PublishSubject<String>()
    var isRequestInProcess = BehaviorSubject<Bool>(value: false)
    
    init() {
        creditCardToValidate
            .filter { !($0.isEmpty) }
            .subscribe( onNext: { text in
                self.verifyCreditCard(data: text)
            }).disposed(by: bag)
    }
    
    private func verifyCreditCard(data: String) {
        isRequestInProcess.onNext(true)
        requestProcessStatus.onNext(.progress)
        CCGenNetworker.default.GET(with: data) { data, response, error in
            self.isRequestInProcess.onNext(false)
            self.requestProcessStatus.onNext(CCGenNetworker.default.parseResponse(data, response, error).successResponse != nil ? .success : .failure)
        }
    }
}
