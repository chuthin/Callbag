//
//  Callbag+Scan.swift
//  Callbag
//
//  Created by chuthin on 7/5/18.
//  Copyright © 2018 chuthin. All rights reserved.
//

import Foundation

public func scan<T,O>(_ seed:O,_ fn:@escaping (O,T)->O) -> Transform<T,O> {
    return { callbagIn in
        return { outPayload in
            if case .start(let outtb) = outPayload {
                var acc:O = seed
                callbagIn(.start({ payload in
                    if case .data(let data) = payload {
                        acc = fn(acc,data)
                        outtb(.data(acc))
                    }else if case .end = payload {
                        outtb(.end)
                    }
                }))
            }
        }
    }
}

public func scan<T,O>(_ seed:O) -> (@escaping (O,T)->O) -> Transform<T,O> {
    return { fn in
        return { callbagIn in
            return { outPayload in
                if case .start(let outtb) = outPayload {
                    var acc:O = seed
                    callbagIn(.start({ payload in
                        if case .data(let data) = payload {
                            acc = fn(acc,data)
                            outtb(.data(acc))
                        }else if case .end = payload {
                            outtb(.end)
                        }
                    }))
                }
            }
        }
    }
}
