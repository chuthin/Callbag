//
//  Map.swift
//  Callbag
//
//  Created by Chu Thin on 7/31/20.
//  Copyright © 2020 Chu Thin. All rights reserved.
//

import Foundation
public func map<A,B>(_ f:@escaping (A) -> B) -> Operator<A,B> {
    return { source in
        return { sink in
            source({ payload in
                sink(payload.map(f))
            })
        }
    }
}
