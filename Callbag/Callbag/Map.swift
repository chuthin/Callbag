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


public func distinctUntilChanged<A:Equatable>() -> Operator<A,A> {
    return { source in
        var last:A? = nil
        return { sink in
            source({ payload in
                if case .data(let data) = payload {
                    if(data != last)
                    {
                        last = data
                        sink(.data(data))
                    }
                  
                }
                else {
                    sink(payload)
                }
                
            })
        }
    }
}



public func distinctUntilChanged<A>(_ f:@escaping (A,A) -> Bool) -> Operator<A,A> {
    return { source in
        var last:A? = nil
        return { sink in
            source({ payload in
                if case .data(let data) = payload {
                    if let value = last {
                        if(f(value,data))
                        {
                            last = data
                            sink(.data(data))
                        }
                    }
                    else{
                       last = data
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
