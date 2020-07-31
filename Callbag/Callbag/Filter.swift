//
//  Filter.swift
//  Callbag
//
//  Created by Chu Thin on 7/31/20.
//  Copyright © 2020 Chu Thin. All rights reserved.
//

import Foundation
public func filter<A>(_ predicate:@escaping (A)-> Bool) -> Operator<A,A> {
    return { source in
        return { sink in
            source({ payload in
                if case .data(let d) = payload {
                    if(predicate(d)){
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
