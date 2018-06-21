//
//  Callbag+foreach.swift
//  Callbag
//
//  Created by chuthin on 6/21/18.
//  Copyright © 2018 chuthin. All rights reserved.
//

import Foundation
extension Callbag {
    public func forEach(_ fn:@escaping(T) -> Void){
        self.source({ payload in
            if case SinkPayload.Start(let tb) = payload {
                tb(SourcePayload.Start)
            }
            if case SinkPayload.Push(let data) = payload {
                fn(data)
            }
        })
    }
}
