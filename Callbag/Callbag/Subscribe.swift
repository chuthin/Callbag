//
//  Subscribe.swift
//  Callbag
//
//  Created by Chu Thin on 7/31/20.
//  Copyright © 2020 Chu Thin. All rights reserved.
//

import Foundation
public func subscribe<T>( onData:@escaping OnData<T>,oneEnd: OnEnd? = nil) -> Subscribable<T> {
    return { source  in
        var talkback:Talkback? = nil
        var disposeLater = false
        source({ payload in
            if case .start(let tb) = payload {
                talkback = tb
                if(disposeLater){
                    talkback?(Payload<T>.end(nil))
                }
            }
            else if case .data(let d) = payload {
                onData(d)
            }
            else if case .end(let d) = payload {
                oneEnd?(d)
            }
        })
        
        return {
            if(talkback != nil){
                talkback?(Payload<T>.end(nil))
            }
            else {
                disposeLater = true
            }
        }
    }
}
