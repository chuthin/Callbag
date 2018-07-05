//
//  Callbag+Skip.swift
//  Callbag
//
//  Created by chuthin on 7/5/18.
//  Copyright © 2018 chuthin. All rights reserved.
//

import Foundation
extension Callbag {
    public func skip(_ max:Int) -> Callbag<T> {
        var taken: Int = 0
        let transform:Transform<T,T> = { source in
            
            let out:Source<T> = { talkback in
                source({ payload in
                    switch(payload){
                    case .Start(let tb):
                        talkback(SinkPayload.Start(tb))
                    case .Push(let v):
                        if(taken < max)
                        {
                            taken += 1
                        }
                        else
                        {
                            talkback(SinkPayload.Push(v))
                            
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
    
    public func skipUntil(_ fn:@escaping (T) -> Bool) -> Callbag<T> {
        let transform:Transform<T,T> = { source in
            var isSkip = true
            let out:Source<T> = { talkback in
                source({ payload in
                    switch(payload){
                    case .Start(let tb):
                        talkback(SinkPayload.Start(tb))
                    case .Push(let v):
                        if(isSkip)
                        {
                            isSkip = !fn(v)
                            if(!isSkip)
                            {
                                talkback(SinkPayload.Push(v))
                            }
                        }
                        else
                        {
                             talkback(SinkPayload.Push(v))
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
