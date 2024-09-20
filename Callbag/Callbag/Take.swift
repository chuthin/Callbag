//
//  Take.swift
//  Callbag
//
//  Created by Chu Thin on 7/31/20.
//  Copyright © 2020 Chu Thin. All rights reserved.
//

import Foundation
public func take<T>(_ n:Int) ->  Operator<T,T> {
    return { source in
        return { sink in
            var talkback:Talkback? = nil
            var ended = false
            var taken = 0
            source({ payload in
                if case .start(let tb) = payload {
                    talkback = tb
                    sink(.start({ _ in
                        ended = true
                        talkback?(Payload<T>.end(nil))
                    }))
                }
                else if case .data(let d) = payload {
                    if(!ended)
                    {
                        if(taken < n){
                            taken += 1
                            sink(.data(d))
                            if(!ended && taken == n){
                                talkback?(Payload<T>.end(nil))
                                sink(.end(nil))
                            }
                        }
                    }
                }
                else {
                    sink(payload)
                }
            })
        }
    }
}

public func takeUntil<T>(_ f:@escaping (T)->Bool) ->  Operator<T,T> {
    return { source in
        return { sink in
            var talkback:Talkback? = nil
            var ended = false
            source({ payload in
                if case .start(let tb) = payload {
                    talkback = tb
                    sink(.start({ _ in
                        ended = true
                        talkback?(Payload<T>.end(nil))
                    }))
                }
                else if case .data(let d) = payload {
                    if(!ended)
                    {
                        if(f(d)){
                            sink(.data(d))
                        }
                        else {
                            talkback?(Payload<T>.end(nil))
                            sink(.end(nil))
                        }
                    }
                }
                else {
                    sink(payload)
                }
            })
        }
    }
}

public func first<T>() -> Operator<T, T> {
    return take(1)
}
