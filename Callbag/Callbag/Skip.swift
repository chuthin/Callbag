//
//  Skip.swift
//  Callbag
//
//  Created by Chu Thin on 7/31/20.
//  Copyright © 2020 Chu Thin. All rights reserved.
//

import Foundation
public func skip<T>(_ n:Int) ->  Operator<T,T> {
    return { source in
        return { sink in
            var skipped = 0;
            source({ payload in
                if case .data(_) = payload {
                    skipped += 1
                    if(!(skipped <= n)){
                        sink(payload)
                    }
                }
                else {
                    sink(payload)
                }
            })
        }
    }
}


public func last<T>() -> Operator<T,T> {
    return { source in
        return { sink in
            var last: T? = nil;
            source({ payload in
                if case .data(let d) = payload {
                    last = d
                }
                else if case .end(_) = payload {
                    if(last !=  nil) {
                        sink(.data(last!))
                        last = nil
                    }
                }
                if case .data(_) = payload {}
                else {
                    sink(payload)
                }
            })
        }
    }
}
