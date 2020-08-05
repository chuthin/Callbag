//
//  From.swift
//  Callbag
//
//  Created by Chu Thin on 7/31/20.
//  Copyright © 2020 Chu Thin. All rights reserved.
//

import Foundation
public func fromArray<T>(_ arr:[T]) -> Producer<T> {
    return { sink in
        var ended = false
        sink(.start({ _ in
            ended = true
        }))
        for item in arr {
            if(ended) {
                break
            }
            sink(.data(item))
        }
        if(!ended){
            sink(.end(nil))
        }
    }
}

public func fromInterval(_ period:TimeInterval) -> Producer<Int> {
    return { sink in
        var timer: Timer?
        var i: Int = 0;
        sink(.start({ payload in
            timer?.invalidate()
            timer = nil
            
        }))
        
        timer = Timer.scheduledTimer(withTimeInterval: period, repeats: true, block: { _ in
            sink(.data(i));
            i += 1;
        })
    }
}

public func fromSubject<T>(_ subject:@escaping Subject<T>) -> Producer<T> {
    return { sink in
        subject(.start(sink))
    }
}

