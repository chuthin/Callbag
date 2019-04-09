//
//  Callbag+Take.swift
//  Callbag
//
//  Created by chuthin on 7/5/18.
//  Copyright © 2018 chuthin. All rights reserved.
//

import Foundation

public func take<T>(_ max:Int) -> Filter<T> {
    return { callbagIn in
        var  taken = 0
        return { outPayload in
            if case .start(let outtb) = outPayload {
                callbagIn(.start({ payload in
                    if case .data(let data) = payload {
                        if(taken < max) {
                            taken += 1
                            outtb(.data(data))
                        }
                        else if( taken == max){
                            callbagIn(.end)
                            outtb(.end)
                        }
                        
                    }else if case .end = payload {
                        outtb(.end)
                    }
                }))
            }
        }
    }
}

public func takeUtil<T>(_ fn:@escaping (T)->Bool) -> Filter<T> {
    return { callbagIn in
        return { outPayload in
            if case .start(let outtb) = outPayload {
                callbagIn(.start({ payload in
                    if case .data(let data) = payload {
                        if(fn(data)) {
                            outtb(.data(data))
                        }
                        else {
                            callbagIn(.end)
                            outtb(.end)
                        }
                    }else if case .end = payload {
                        outtb(.end)
                    }
                }))
            }
        }
    }
}
