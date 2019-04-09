//
//  Callbag+FromInterval.swift
//  Callbag
//
//  Created by chuthin on 6/21/18.
//  Copyright © 2018 chuthin. All rights reserved.
//

import Foundation
public func fromInterval(_ period:Double) -> Callbag<Int> {
    return { payload in
        var sink:Callbag<Int>?
        var timer: Timer?
        var i: Int = 0;
        if case .start(let cb) = payload {
            sink = cb
            timer = Timer.scheduledTimer(withTimeInterval: period, repeats: true, block: { _ in
                sink?(.data(i));
                i += 1;
            })
            sink?(.start({ sourcePayload in
                if case .data(let dt) = sourcePayload {
                    i = dt
                }
                if case .end = sourcePayload {
                    timer?.invalidate()
                    timer = nil
                    sink = nil
                }
            }))
        }
    }
}


