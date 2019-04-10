//
//  Callbag+CombineLatest.swift
//  Callbag
//
//  Created by chuthin on 6/21/18.
//  Copyright © 2018 chuthin. All rights reserved.
//

import Foundation

public func combineLastest<L,R,O> ( _ left:@escaping Callbag<L>, _ right:@escaping Callbag<R>, _ fn:@escaping (L,R) -> O)  -> Callbag<O> {
    return { payload in
        var lastL:L?
        var lastR:R?
        if case .start(let tb) = payload  {
            left(.start({ payloadLeft in
                if case .data(let dataLeft) = payloadLeft {
                    lastL = dataLeft
                    if let l = lastL, let r = lastR {
                        tb(.data(fn(l,r)))
                    }
                }
                else if case .end = payloadLeft{
                    tb(.end)
                }
            }))
            
            right(.start({ payloadRight in
                if case .data(let dataRight) = payloadRight {
                    lastR = dataRight
                    if let l = lastL, let r = lastR {
                        tb(.data(fn(l,r)))
                    }
                }
                else if case .end = payloadRight{
                    tb(.end)
                }
            }))
        }
    }
}
