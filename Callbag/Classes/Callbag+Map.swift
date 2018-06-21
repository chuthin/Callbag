
//
//  Callbag+map.swift
//  Callbag
//
//  Created by chuthin on 6/21/18.
//  Copyright © 2018 chuthin. All rights reserved.
//
import Foundation
extension Callbag {
    public func map<O>(_ fn:@escaping (T)->O) -> Callbag<O> {
        let transform:Transform<T,O> = { source in
            let out:Source<O> = { talkback in
                source({ payload in
                    switch(payload){
                    case .Start(let tb):
                        talkback(SinkPayload.Start(tb))
                    case .Push(let v):
                        talkback(SinkPayload.Push(fn(v)))
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
