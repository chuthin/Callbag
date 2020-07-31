//
//  Merge.swift
//  Callbag
//
//  Created by Chu Thin on 7/31/20.
//  Copyright © 2020 Chu Thin. All rights reserved.
//

import Foundation

public func merge<T>(_ sources: Source<T>...) -> Source<T> {
    return { sink in
        let n = sources.count
        var ended = false
        var sourceTalkback:[Talkback?] = Array(repeating: nil, count: n)
        var startCount = 0
        var endcount = 0
        
        let talkback:Talkback = { d in
            ended = true
            for tb in sourceTalkback {
                tb?(Payload<T>.end(d))
            }
        }
        
        for i in (0...n-1) {
            if(!ended){
                sources[i]({ payload in
                    if case .start(let tb) = payload {
                        sourceTalkback[i] = tb
                        startCount += 1
                        if(startCount == 1){
                            sink(.start(talkback))
                        }
                    }
                    else  if case .data(_) = payload {
                        sink(payload)
                    }
                    else if case .end(let d) = payload {
                        if(d != nil)
                        {
                            ended = true
                            for j in 1...n-1 {
                                if(j != i){
                                    sourceTalkback[j]?(Payload<T>.end(nil))
                                }
                            }
                            sink(.end(d))
                        }
                        else {
                            sourceTalkback[i] = nil
                            endcount += 1
                            if(endcount == n){
                                sink(.end(nil))
                            }
                        }
                    }
                })
            }
        }
    }
}
