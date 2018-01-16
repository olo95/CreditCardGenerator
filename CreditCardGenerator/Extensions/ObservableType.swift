//
//  ObservableType.swift
//  CreditCardGenerator
//
//  Created by Alexander Stolar on 16.01.2018.
//  Copyright © 2018 Alexander Stolar. All rights reserved.
//

import RxSwift

extension ObservableType {
    
    public func unwrap<T>() -> Observable<T> where E == T? {
        return self.filter { $0 != nil }.map { $0! }
    }
}
