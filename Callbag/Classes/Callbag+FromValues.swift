//
//  Callbag+FromValues.swift
//  Callbag
//
//  Created by chuthin on 6/21/18.
//  Copyright © 2018 chuthin. All rights reserved.
//
import Foundation
extension Callbag {
    
    public static func fromValues(_ values:T...) -> Callbag<T> {
        let source :Source<T> = { stb in
            var talkback:SinkTalkback<T>? = stb
            talkback?(SinkPayload.Start({ payload in
                if case SourcePayload.Start = payload {
                    for value in values {
                        talkback?(SinkPayload.Push(value))
                    }
                    talkback?(SinkPayload.End)
                }
                if case SourcePayload.End = payload {
                    talkback = nil
                }
            }))
        }
        return Callbag(source: source)
    }
}
