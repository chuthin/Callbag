//
//  Callbag+Skip.swift
//  Callbag
//
//  Created by chuthin on 7/5/18.
//  Copyright © 2018 chuthin. All rights reserved.
//

import Foundation

public func skip<T>(_ max:Int) -> Filter<T> {
    let result:Filter<T> = { callbagIn in
        var  skipped = 0
        let callbagOut:Callbag<T> = { outPayload in
            if case Payload<T>.start(let outtb) = outPayload {
                callbagIn(Payload<T>.start({ payload in
                    if case Payload<T>.data(let data) = payload {
                        if(skipped < max) {
                            skipped += 1
                        }
                        else{
                            outtb(Payload<T>.data(data))
                        }
                    }else if case Payload<T>.end = payload {
                        outtb(Payload<T>.end)
                    }
                }))
            }
        }
        return callbagOut
    }
    return result
}

public func skipUtil<T>(_ fn:@escaping (T)->Bool) -> Filter<T> {
    return { callbagIn in
        return { outPayload in
            var isSkip = true
            if case .start(let outtb) = outPayload {
                callbagIn(.start({ payload in
                    if case .data(let data) = payload {
                        if(isSkip)
                        {
                            isSkip = !fn(data)
                            if(!isSkip)
                            {
                                outtb(.data(data))
                            }
                        }
                        else
                        {
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
