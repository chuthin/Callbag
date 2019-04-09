//
//  Callbag+foreach.swift
//  Callbag
//
//  Created by chuthin on 6/21/18.
//  Copyright © 2018 chuthin. All rights reserved.
//

import Foundation
public func forEach<T>(_ fn:@escaping (T) -> Void) -> Callbag<T> {
    let result:Callbag<T> = { payload in
        if case .data(let value) = payload {
            fn(value)
        }
    }
    return result
}
