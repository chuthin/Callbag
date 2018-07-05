//
//  Callbag+Filter.swift
//  Callbag
//
//  Created by chuthin on 6/21/18.
//  Copyright © 2018 chuthin. All rights reserved.
//

import Foundation
extension Callbag {
    public func filter(_ fn:@escaping (T) -> Bool) -> Callbag<T> {
        let transform:Transform<T,T> = { source in
            let out:Source<T> = { talkback in
                source({ payload in
                    switch(payload){
                    case .Start(let tb):
                        talkback(SinkPayload.Start(tb))
                    case .Push(let v):
                        if(fn(v))
                        {
                            talkback(SinkPayload.Push(v))
                        }
                        else
                        {
                            talkback(SinkPayload.End)
                        }
                    case .End:
                        talkback(SinkPayload.End)
                    }
                })
            }
            return out
        }
        return Callbag<T>(source:transform(self.source))
    }
}
