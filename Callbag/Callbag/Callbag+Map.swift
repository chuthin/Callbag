
//
//  Callbag+map.swift
//  Callbag
//
//  Created by chuthin on 6/21/18.
//  Copyright © 2018 chuthin. All rights reserved.
//
import Foundation

public func map<T,O>(_ fn:@escaping (T) -> O) -> Transform<T,O> {
    return { callbagIn in
        return { outPayload in
            if case .start(let outtb) = outPayload {
                callbagIn(.start({ payload in
                    if case .data(let data) = payload {
                        outtb(.data(fn(data)))
                    }else if case .end = payload {
                        outtb(.end)
                    }
                }))
            }
        }
    }
}
