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
    
    var creditCardtToValidate = BehaviorSubject<String>(value: "")
    
    init() {
        creditCardtToValidate
            .subscribe( onNext: { text in
                self.verifyCreditCard(data: text)
            }).disposed(by: bag)
    }
    
    private func verifyCreditCard(data: String) {
        
        let methodParameters = [
            ConstantsAPI.formatTitle: ConstantsAPI.format,
            ConstantsAPI.apiKeyTitle: ConstantsAPI.apiKey,
            ConstantsAPI.ccTitle: ""
        ]
        
        let session = URLSession.shared
        let urlString = ConstantsAPI.baseURL + escapedParameters(methodParameters as [String:AnyObject])
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
        }
        task.resume()
    }
    
    private func escapedParameters(_ parameters: [String:AnyObject]) -> String {
        
        if parameters.isEmpty {
            return ""
        } else {
            var keyValuePairs = [String]()
            for (key, value) in parameters {
                let stringValue = "\(value)"
                let escapedValue = stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                keyValuePairs.append(key + "=" + "\(escapedValue!)")
            }
            return "?\(keyValuePairs.joined(separator: "&"))"
        }
    }
}
