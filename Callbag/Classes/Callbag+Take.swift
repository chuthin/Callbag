//
//  Callbag+Take.swift
//  Callbag
//
//  Created by chuthin on 7/5/18.
//  Copyright © 2018 chuthin. All rights reserved.
//

import Foundation
extension Callbag {
    public func take(_ max:Int) -> Callbag<T> {
        var taken: Int = 0
        let transform:Transform<T,T> = { source in
            var stb:SourceTalkback?
            let out:Source<T> = { talkback in
                source({ payload in
                    switch(payload){
                    case .Start(let tb):
                        stb = tb
                        talkback(SinkPayload.Start(tb))
                    case .Push(let v):
                        if(taken < max)
                        {
                            taken += 1
                            talkback(SinkPayload.Push(v))
                        }
                        else
                        {
                            
                            talkback(SinkPayload.End)
                            stb?(SourcePayload.End)
                            stb = nil
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
    
    public func takeUntil(_ fn:@escaping (T) -> Bool) -> Callbag<T> {
        let transform:Transform<T,T> = { source in
            var stb:SourceTalkback?
            let out:Source<T> = { talkback in
                source({ payload in
                    switch(payload){
                    case .Start(let tb):
                        stb = tb
                        talkback(SinkPayload.Start(tb))
                    case .Push(let v):
                        if(fn(v))
                        {
                            talkback(SinkPayload.Push(v))
                        }
                        else
                        {
                            talkback(SinkPayload.End)
                            stb?(SourcePayload.End)
                             stb = nil
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
