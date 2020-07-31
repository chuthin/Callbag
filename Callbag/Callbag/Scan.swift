//
//  Scan.swift
//  Callbag
//
//  Created by Chu Thin on 7/31/20.
//  Copyright © 2020 Chu Thin. All rights reserved.
//

import Foundation
public func scan<A,B>(_ start:B,_ f:@escaping(B,A) -> B) -> Operator<A,B> {
    return { source in
        return { sink in
            var acc = start
            source({ payload in
                
                if case .start(let tb) = payload {
                    sink(.start(tb))
                    sink(.data(acc))
                }
                else  if case .data(let d) = payload {
                    acc = f(acc,d)
                    sink(.data(acc))
                }
                else if case .end(let d) = payload {
                    sink(.end(d))
                }
            })
        }
    }
}
