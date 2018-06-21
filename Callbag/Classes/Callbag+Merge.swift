//
//  Merge.swift
//  Callbag
//
//  Created by chuthin on 6/21/18.
//  Copyright © 2018 chuthin. All rights reserved.
//

import Foundation
extension Callbag where T == Any {
    public static func merge<T>(_ callbags:Callbag<T>...) -> Callbag<T> {
        let sources = callbags.map{$0.source}
        let out:Source<T> = { talkback in
            for i in 0...sources.count - 1 {
                sources[i]({ payload in
                    switch(payload){
                    case .Start(let tb):
                        talkback(SinkPayload.Start(tb))
                    case .Push(let v):
                        talkback(SinkPayload.Push(v))
                    case .End:
                        talkback(SinkPayload.End)
                    }
                })
            }
        }
        return Callbag<T>(source:out)
    }
}

