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
            .filter { !($0.isEmpty) }
            .subscribe( onNext: { text in
                self.verifyCreditCard(data: text)
            }).disposed(by: bag)
    }
    
    private func verifyCreditCard(data: String) {
        
        let cc = data[ConstantsCreditCardTemplate.creditCardNumber].replacingOccurrences(of: " ", with: "")
        
        let methodParameters: [(String,String)] = [
            (ConstantsAPI.formatTitle, ConstantsAPI.format),
            (ConstantsAPI.apiKeyTitle, ConstantsAPI.apiKey),
            (ConstantsAPI.ccTitle, cc)
        ]
        
        let session = URLSession.shared
        let urlString = ConstantsAPI.baseURL + escapedParameters(methodParameters) + "/"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            func displayError(_ error: String) {
                print(error)
                print("URL at time of error: \(url)")
            }
            guard (error == nil) else {
                displayError("There was an error with your request: \(error!)")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                displayError("Your request returned a status code other than 2xx!")
                return
            }
            
            guard let data = data else {
                displayError("No data was returned by the request!")
                return
            }
            
            let parsedResult: [String:AnyObject]!
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject]
                print(parsedResult)
            } catch {
                displayError("Could not parse the data as JSON: '\(data)'")
                return
            }
            
        }
        task.resume()
    }
    
    private func escapedParameters(_ parameters: [(String, String)]) -> String {
        
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
