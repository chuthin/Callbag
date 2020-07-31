//
//  Subject.swift
//  Callbag
//
//  Created by Chu Thin on 7/31/20.
//  Copyright © 2020 Chu Thin. All rights reserved.
//

import Foundation
public func makeSubject<T>() -> Subject<T> {
    var sinks:[String : Sink<T>?] = [:]
    return { payload in
        if case .start(let tb) = payload {
            let sink = tb
            let key = UUID().uuidString
            sinks[key] = sink
            sink(.start({ _ in
                sinks[key] = nil
            }))
        }else {
            var hasDeleted = false
            for key in sinks.keys {
                if(sinks[key] != nil){
                    if let pl = payload.toPayloadWithoutStart() {
                        sinks[key]??(pl)
                    }
                }
                else {
                    hasDeleted = true
                }
            }
            
            if(hasDeleted){
                sinks = sinks.filter{$0.value != nil}
            }
        }
    }
}

public func makeReplaySubject<T>(_ value:T)  -> Subject<T> {
    var sinks:[String : Sink<T>?] = [:]
    var buffer = value
    return { payload in
        if case .start(let tb) = payload {
            let sink = tb
            let key = UUID().uuidString
            sinks[key] = sink
            sink(.start({ _ in
                sinks[key] = nil
            }))
            
            sink(.data(buffer))
        }else {
            if case .data(let d) = payload {
                buffer = d
            }
            var hasDeleted = false
            for key in sinks.keys {
                if(sinks[key] != nil){
                    if let pl = payload.toPayloadWithoutStart() {
                        sinks[key]??(pl)
                    }
                }
                else {
                    hasDeleted = true
                }
            }
            
            if(hasDeleted){
                sinks = sinks.filter{$0.value != nil}
            }
        }
    }
}
