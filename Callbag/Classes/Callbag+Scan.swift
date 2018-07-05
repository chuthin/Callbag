//
//  Callbag+Scan.swift
//  Callbag
//
//  Created by chuthin on 7/5/18.
//  Copyright © 2018 chuthin. All rights reserved.
//

import Foundation
extension Callbag {
    public func scan<O>(_ seed:O,_ fn:@escaping (O,T)->O) -> Callbag<O> {
        let transform:Transform<T,O> = { source in
            var acc:O = seed
            let out:Source<O> = { talkback in
                source({ payload in
                    switch(payload){
                    case .Start(let tb):
                        talkback(SinkPayload.Start(tb))
                    case .Push(let v):
                        acc = fn(acc,v)
                        talkback(SinkPayload.Push(acc))
                    case .End:
                        talkback(SinkPayload.End)
                    }
                })
            }
            return out
        }
        return Callbag<O>(source:transform(self.source))
    }
    
    public func scan<O>(_ seed:O) ->((@escaping (O,T)->O) -> Callbag<O>) {
        return { fn in
            let transform:Transform<T,O> = { source in
                var acc:O = seed
                let out:Source<O> = { talkback in
                    source({ payload in
                        switch(payload){
                        case .Start(let tb):
                            talkback(SinkPayload.Start(tb))
                        case .Push(let v):
                            acc = fn(acc,v)
                            talkback(SinkPayload.Push(acc))
                        case .End:
                            talkback(SinkPayload.End)
                        }
                    })
                }
                return out
            }
            return Callbag<O>(source:transform(self.source))
        }
    }
}
