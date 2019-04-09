//
//  Callbag+CombineLatest.swift
//  Callbag
//
//  Created by chuthin on 6/21/18.
//  Copyright © 2018 chuthin. All rights reserved.
//

import Foundation
/*
extension Callbag where T == Any {
    public static func combineLastest<T1,T2,T>(_ callbag1:Callbag<T1>,_ callbag2:Callbag<T2>,fn:@escaping(T1,T2) -> T) -> Callbag<T> {
        let source1:Source<T1> = callbag1.source
        let source2:Source<T2> = callbag2.source
        var lastA:T1?
        var lastB:T2?
        
        let out:Source<T> = { talkback in
            source1({ payload in
                switch(payload){
                case .Start(let tb):
                    talkback(SinkPayload.Start(tb))
                case .Push(let v):
                    lastA = v
                    if let a = lastA,let b = lastB
                    {
                        talkback(SinkPayload.Push(fn(a,b)))
                    }
                case .End:
                    talkback(SinkPayload.End)
                }
            })
            
            source2({ payload in
                switch(payload){
                case .Start(let tb):
                    talkback(SinkPayload.Start(tb))
                case .Push(let v):
                    lastB = v
                    if let a = lastA,let b = lastB
                    {
                        talkback(SinkPayload.Push(fn(a,b)))
                    }
                case .End:
                    talkback(SinkPayload.End)
                }
            })
        }
        
        return Callbag<T>(source:out)
    }
    
    public static func combineLastest<T1,T2,T3,T>(callbag1:Callbag<T1>,callbag2:Callbag<T2>,callbag3:Callbag<T3>,fn:@escaping(T1,T2,T3) -> T) -> Callbag<T> {
        let source1:Source<T1> = callbag1.source
        let source2:Source<T2> = callbag2.source
        let source3:Source<T3> = callbag3.source
        var last1:T1?
        var last2:T2?
        var last3:T3?
        
        let out:Source<T> = { talkback in
            source1({ payload in
                switch(payload){
                case .Start(let tb):
                    talkback(SinkPayload.Start(tb))
                case .Push(let v):
                    last1 = v
                    if let l1 = last1,let l2 = last2 , let l3 = last3
                    {
                        talkback(SinkPayload.Push(fn(l1,l2,l3)))
                    }
                case .End:
                    talkback(SinkPayload.End)
                }
            })
            
            source2({ payload in
                switch(payload){
                case .Start(let tb):
                    talkback(SinkPayload.Start(tb))
                case .Push(let v):
                    last2 = v
                    if let l1 = last1,let l2 = last2 , let l3 = last3
                    {
                        talkback(SinkPayload.Push(fn(l1,l2,l3)))
                    }
                case .End:
                    talkback(SinkPayload.End)
                }
            })
            
            source3({ payload in
                switch(payload){
                case .Start(let tb):
                    talkback(SinkPayload.Start(tb))
                case .Push(let v):
                    last3 = v
                    if let l1 = last1,let l2 = last2 , let l3 = last3
                    {
                        talkback(SinkPayload.Push(fn(l1,l2,l3)))
                    }
                case .End:
                    talkback(SinkPayload.End)
                }
            })
        }
        
        return Callbag<T>(source:out)
    }
}
*/
