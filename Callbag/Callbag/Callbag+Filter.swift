//
//  Callbag+Filter.swift
//  Callbag
//
//  Created by chuthin on 6/21/18.
//  Copyright © 2018 chuthin. All rights reserved.
//

import Foundation
public func filter<T>(_ fn:@escaping (T) -> Bool) -> Filter<T> {
    return { callbagIn in
        return { outPayload in
            if case .start(let outtb) = outPayload {
                callbagIn(.start({ payload in
                    if case .data(let data) = payload {
                        if(fn(data)) {
                            outtb(.data(data))
                        }
                    }else if case .end = payload {
                        outtb(.end)
                    }
                }))
            }
        }
    }
}
