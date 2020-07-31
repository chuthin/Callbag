//
//  Combine.swift
//  Callbag
//
//  Created by Chu Thin on 7/31/20.
//  Copyright © 2020 Chu Thin. All rights reserved.
//

import Foundation

public func combine<S1,S2,R>(_ s1:@escaping Source<S1>,_ s2:@escaping Source<S2>,_ f:@escaping(S1,S2)-> R) -> Source<R> {
    return { sink in
        var ended = false
        var talkback1:Talkback? = nil
        var talkback2:Talkback? = nil
        var startCount = 0
        var endcount = 0
        var v1:S1?
        var v2:S2?
        let talkback:Talkback = { d in
            ended = true
            talkback1?(Payload<S1>.end(d))
            talkback2?(Payload<S2>.end(d))
        }
        
        func sinkWithIndex<O>(_ index:Int) -> Sink<O> {
            return { payload in
                if(!ended){
                    if case .start(let tb) = payload {
                        if(index == 1)
                        {
                            talkback1 = tb
                        }
                        else {
                            talkback2 = tb
                        }
                        
                        startCount += 1
                        if(startCount == 1){
                            sink(.start(talkback))
                        }
                        
                    }else  if case .data(let d) = payload {
                        if(index == 1)
                        {
                            v1 = d as? S1
                        }
                        else {
                            v2 = d as? S2
                        }
                        if let l = v1,let r = v2 {
                            sink(.data(f(l,r)))
                        }
                    }
                    else if case .end(let d) = payload {
                        if(d != nil)
                        {
                            ended = true
                            if(index == 1)
                            {
                                talkback1?(Payload<S1>.end(d))
                            }
                            else {
                                talkback2?(Payload<S2>.end(d))
                            }
                            
                            sink(.end(d))
                        }
                        else {
                            if(index == 1)
                            {
                                talkback1?(Payload<S1>.end(nil))
                                talkback1 = nil
                            }
                            else {
                                talkback2?(Payload<S2>.end(nil))
                                talkback2 = nil
                            }
                            endcount += 1
                            if(endcount == 2){
                                sink(.end(nil))
                            }
                        }
                    }
                }
            }
        }
        
        s1(sinkWithIndex(1))
        s2(sinkWithIndex(2))
    }
}



public func combine<S1,S2,S3,R>(_ s1:@escaping Source<S1>,_ s2:@escaping Source<S2>,_ s3:@escaping Source<S3>,_ f:@escaping (S1,S2,S3) -> R) -> Source<R> {
    return { sink in
        var ended = false
        var talkback1:Talkback? = nil
        var talkback2:Talkback? = nil
        var talkback3:Talkback? = nil
        var startCount = 0
        var endcount = 0
        var v1:S1?
        var v2:S2?
        var v3:S3?
        let talkback:Talkback = { d in
            ended = true
            talkback1?(Payload<S1>.end(d))
            talkback2?(Payload<S2>.end(d))
            talkback3?(Payload<S3>.end(d))
        }
        
        func sinkWithIndex<O>(_ index:Int) -> Sink<O> {
            return { payload in
                if(!ended){
                    if case .start(let tb) = payload {
                        switch index {
                        case 1: talkback1 = tb
                        case 2:talkback2 = tb
                        default:talkback3 = tb
                        }
                        startCount += 1
                        if(startCount == 1){
                            sink(.start(talkback))
                        }
                        
                    }else  if case .data(let d) = payload {
                        switch index {
                        case 1: v1 = d as? S1
                        case 2: v2 = d as? S2
                        default:v3 = d as? S3
                        }
                        if let r1 = v1,let r2 = v2,let r3 = v3 {
                            sink(.data(f(r1,r2,r3)))
                        }
                    }
                    else if case .end(let d) = payload {
                        if(d != nil)
                        {
                            ended = true
                            switch index {
                            case 1: talkback1?(Payload<S1>.end(d))
                            case 2: talkback2?(Payload<S2>.end(d))
                            default:talkback3?(Payload<S3>.end(d))
                            }
                            sink(.end(d))
                        }
                        else {
                            switch index {
                            case 1: talkback1?(Payload<S1>.end(nil))
                            talkback1 = nil
                            case 2: talkback2?(Payload<S2>.end(nil))
                            talkback2 = nil
                            default:talkback3?(Payload<S3>.end(nil))
                            talkback3 = nil
                            }
                            endcount += 1
                            if(endcount == 3){
                                sink(.end(nil))
                            }
                        }
                    }
                }
            }
        }
        
        s1(sinkWithIndex(1))
        s2(sinkWithIndex(2))
        s3(sinkWithIndex(3))
    }
}

public func combine<S1,S2,S3,S4,R>(_ s1:@escaping Source<S1>,_ s2:@escaping Source<S2>,_ s3:@escaping Source<S3>,_ s4:@escaping Source<S4>,_ f:@escaping (S1,S2,S3,S4) -> R) -> Source<R> {
    return { sink in
        var ended = false
        var talkback1:Talkback? = nil
        var talkback2:Talkback? = nil
        var talkback3:Talkback? = nil
        var talkback4:Talkback? = nil
        var startCount = 0
        var endcount = 0
        var v1:S1?
        var v2:S2?
        var v3:S3?
        var v4:S4?
        let talkback:Talkback = { d in
            ended = true
            talkback1?(Payload<S1>.end(d))
            talkback2?(Payload<S2>.end(d))
            talkback3?(Payload<S3>.end(d))
        }
        
        func sinkWithIndex<O>(_ index:Int) -> Sink<O> {
            return { payload in
                if(!ended){
                    if case .start(let tb) = payload {
                        switch index {
                        case 1: talkback1 = tb
                        case 2:talkback2 = tb
                        case 3:talkback3 = tb
                        default:talkback4 = tb
                        }
                        startCount += 1
                        if(startCount == 1){
                            sink(.start(talkback))
                        }
                        
                    }else  if case .data(let d) = payload {
                        switch index {
                        case 1: v1 = d as? S1
                        case 2: v2 = d as? S2
                        case 3: v3 = d as? S3
                        default:v4 = d as? S4
                        }
                        if let r1 = v1,let r2 = v2,let r3 = v3,let r4=v4 {
                            sink(.data(f(r1,r2,r3,r4)))
                        }
                    }
                    else if case .end(let d) = payload {
                        if(d != nil)
                        {
                            ended = true
                            switch index {
                            case 1: talkback1?(Payload<S1>.end(d))
                            case 2: talkback2?(Payload<S2>.end(d))
                            case 3:talkback3?(Payload<S3>.end(d))
                            default:talkback4?(Payload<S4>.end(d))
                            }
                            sink(.end(d))
                        }
                        else {
                            switch index {
                            case 1: talkback1?(Payload<S1>.end(nil))
                            talkback1 = nil
                            case 2: talkback2?(Payload<S2>.end(nil))
                            talkback2 = nil
                            case 3:talkback3?(Payload<S3>.end(nil))
                            talkback3 = nil
                            default:talkback4?(Payload<S4>.end(nil))
                            talkback4 = nil
                            }
                            endcount += 1
                            if(endcount == 4){
                                sink(.end(nil))
                            }
                        }
                    }
                }
            }
        }
        
        s1(sinkWithIndex(1))
        s2(sinkWithIndex(2))
        s3(sinkWithIndex(3))
        s4(sinkWithIndex(4))
    }
}

public func combineWith<A,B,R>(_ source:@escaping Source<A>,_ f:@escaping (A,B) -> R) ->Operator<B,R> {
    return { source2 in
        return combine(source, source2, f)
    }
}
