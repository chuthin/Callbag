//
//  Create.swift
//  Callbag
//
//  Created by Chu Thin on 7/31/20.
//  Copyright © 2020 Chu Thin. All rights reserved.
//

import Foundation

public func create<T>(_ observer: @escaping (@escaping (T)-> Void,@escaping (Any?)->Void)->Void,onComplete:OnEnd? = nil) -> Source<T> {
    return { sink in
        var ended = false
        let next:(T)->Void = { t in
            if(!ended){
                sink(.data(t))
            }
        }
        
        let complete :(Any?) -> Void = { err in
            if(!ended){
                sink(.end(err))
                onComplete?(err)
            }
        }
        
        sink(.start({ _ in
            ended = true
            onComplete?(nil)
        }))
        
        observer(next,complete)
    }
}

public func empty<T>() -> Source<T> {
    return { sink in
        var ended = false
        sink(.start{ _ in
            ended = true
            })
        if(!ended){
            sink(.end(nil))
        }
    }
}

public func never<T>() -> Source<T> {
    return { sink in
        sink(.start({_ in }))
    }
}
