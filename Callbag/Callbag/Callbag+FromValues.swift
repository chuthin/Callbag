//
//  Callbag+FromValues.swift
//  Callbag
//
//  Created by chuthin on 6/21/18.
//  Copyright © 2018 chuthin. All rights reserved.
//
import Foundation

public func fromValues<T>(_ values:T...) -> Callbag<T> {
    return { payload in
        if case .start(let tb) = payload {
            for value in values {
                tb(.data(value))
            }
            tb(.end)
        }
    }
}
