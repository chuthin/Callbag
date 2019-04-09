//
//  Merge.swift
//  Callbag
//
//  Created by chuthin on 6/21/18.
//  Copyright © 2018 chuthin. All rights reserved.
//

import Foundation

public func merge<T>( _ sources:Callbag<T>...) -> Callbag<T> {
    return { payload in
        if case .start(let tb) = payload {
            for source in sources {
                source(.start({ pl in
                    if  case .data(let dt) = pl {
                        tb(.data(dt))
                    }
                }))
            }
        }
    }
}
