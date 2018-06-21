//
//  Callbag+FromInterval.swift
//  Callbag
//
//  Created by chuthin on 6/21/18.
//  Copyright © 2018 chuthin. All rights reserved.
//

import Foundation
extension Callbag where T == Any{
    public static func fromInterval(period:Double) -> Callbag<Int> {
        let source :Source<Int> = { tb in
            var timer: Timer?
            var i: Int = 0;
            var talkback: SinkTalkback<Int>? = tb
            func block (t: Timer) {
                talkback?(SinkPayload.Push(i));
                i += 1;
            }
            
            talkback?(SinkPayload.Start({ payload in
                if case SourcePayload.Start = payload{
                    if #available(iOS 10.0, *) {
                        timer = Timer.scheduledTimer(withTimeInterval: period, repeats: true, block: block)
                    } else {
                        // Fallback on earlier versions
                        //timer = Timer.scheduledTimer(timeInterval: period, target: self, selector: <#T##Selector#>, userInfo: <#T##Any?#>, repeats: <#T##Bool#>)
                    };
                }
                
                if case SourcePayload.End = payload {
                    timer?.invalidate()
                    
                    timer = nil
                    talkback = nil
                }
                timer?.fire();
            }))
        }
        return Callbag<Int>(source: source)
    }
}


