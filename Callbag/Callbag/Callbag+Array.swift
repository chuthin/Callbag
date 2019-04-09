//
//  Callbag.swift
//  Callbag
//
//  Created by chuthin on 6/21/18.
//  Copyright © 2018 chuthin. All rights reserved.
//

import Foundation
public func fromArray<T>(_ items:[T]) -> Callbag<T> {
    return { payload in
        if case .start(let tb) = payload {
            for item in items {
                tb(.data(item))
            }
            tb(.end)
        }
    }
}
