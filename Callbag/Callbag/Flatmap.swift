//
//  Flatmap.swift
//  Callbag
//
//  Created by Chu Thin on 7/31/20.
//  Copyright © 2020 Chu Thin. All rights reserved.
//

import Foundation
public func flatmap<A,B>(_ f:@escaping(A)->Producer<B>) -> Operator<A,B> {
    return { source in
        return { sink in
            var outerTalkback:Talkback?
            var innerTalkback:Talkback?
            var outerEnded = false;
            let talkBack:Talkback = { pl in
                outerTalkback?(Payload<A>.end(nil))
                innerTalkback?(Payload<B>.end(nil))
            }
            
            source({ payload in
                if case .start(let tb) = payload {
                    outerTalkback = tb
                    sink(.start(talkBack))
                }else  if case .data(let d) = payload {
                    let innerProducer:Producer<B> = f(d)
                    innerTalkback?(Payload<B>.end(nil))
                    innerProducer({ innerPayload in
                        if case .start(let inertb) = innerPayload {
                            innerTalkback = inertb
                        }
                        else if case .data(let data) = innerPayload {
                            sink(.data(data))
                        }
                        else if case .end(let value) = innerPayload {
                            if(value != nil){
                                outerTalkback?(Payload<A>.end(value))
                                sink(.end(value))
                            }
                            else {
                                if(outerEnded){
                                    sink(.end(nil))
                                }
                                else{
                                    innerTalkback = nil
                                }
                            }
                        }
                    })
                }
                else if case .end(let d) = payload {
                    if(d != nil){
                        innerTalkback?(Payload<B>.end(d))
                        sink(.end(d))
                    }
                    else {
                        if(innerTalkback == nil){
                            outerEnded = true
                        }
                        sink(.end(nil))
                    }
                }
            })
        }
    }
}
