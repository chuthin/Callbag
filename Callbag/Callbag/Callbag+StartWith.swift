//
//  Callbag+StartWith.swift
//  ActionKit
//
//  Created by chuthin on 4/10/19.
//

import Foundation
public func startWith<T>(_ value:T) -> Transform<T,T> {
    return { callbagIn in
        return { outPayload in
            if case .start(let outtb) = outPayload {
                outtb(.data(value))
                
                callbagIn(.start({ payload in
                    if case .data(let data) = payload {
                        outtb(.data(data))
                    }else if case .end = payload {
                        outtb(.end)
                    }
                }))
            }
        }
    }
}
