//
//  CCGenNetworker.swift
//  CreditCardGenerator
//
//  Created by Alexander Stolar on 17.01.2018.
//  Copyright © 2018 Alexander Stolar. All rights reserved.
//

import Foundation

class CCGenNetworker {
    
    static func GET(with creditCardData: String, completionHandler: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()) {
        
        let cc = creditCardData[ConstantsCreditCardTemplate.creditCardNumber].replacingOccurrences(of: " ", with: "")
        let methodParameters: [(String,String)] = [
            (ConstantsAPI.formatTitle, ConstantsAPI.format),
            (ConstantsAPI.apiKeyTitle, ConstantsAPI.apiKey),
            (ConstantsAPI.ccTitle, cc)
        ]
        
        let session = URLSession.shared
        let urlString = ConstantsAPI.baseURL + escapedParameters(methodParameters)
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            completionHandler(data, response, error)
        }
        task.resume()
    }
    
    static func parseResponse(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> CreditCardResponse {
        
        guard (error == nil) else {
            print("There was an error with your request: \(error!)")
            return CreditCardResponse(errorResponse: nil, successResponse: nil)
        }
        
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
            print("Your request returned a status code other than 2xx!")
            return CreditCardResponse(errorResponse: nil, successResponse: nil)
        }
        
        guard let data = data else {
            print("No data was returned by the request!")
            return CreditCardResponse(errorResponse: nil, successResponse: nil)
        }
        
        let parsedResult: [String:AnyObject]!
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject]
            return CreditCardResponse(errorResponse: CreditCardErrorResponse(json: parsedResult), successResponse: CreditCard(json: parsedResult))
            print(parsedResult)
            
        } catch {
            print("Could not parse the data as JSON: '\(data)'")
            return CreditCardResponse(errorResponse: nil, successResponse: nil)
        }
    }
    
    private static func escapedParameters(_ parameters: [(String, String)]) -> String {
        
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
