//
//  Callbag+FromEvent.swift
//  ActionKit
//
//  Created by chuthin on 6/21/18.
//  Copyright © 2018 chuthin. All rights reserved.
//

import Foundation
import ActionKit

public typealias Control = UIKit.UIControl
public typealias ControlEvents = UIKit.UIControlEvents
public typealias EventCallback = (Control) -> Void

extension Callbag where T == Any{
    public static func fromEvent(_ control:Control,_ controlEvents:ControlEvents) -> Callbag<Void> {
        let source :Source<Void> = { sink in
            var talkback: SinkTalkback<Void>? = sink
            talkback?(SinkPayload.Start({ payload in
                if case SourcePayload.Start = payload {
                    control.addControlEvent(controlEvents, { _ in
                        
                        talkback?(SinkPayload.Push(Void()))
                    })
                }
                
                if case SourcePayload.End = payload {
                    talkback = nil
                    control.removeControlEvent(controlEvents)
                }
            }))
        }
        return Callbag<Void>(source: source)
    }
    
    public static func textFrom(_ control:UITextField) -> Callbag<String> {
        let source :Source<String> = { sink in
            var talkback: SinkTalkback<String>? = sink
            
            talkback?(SinkPayload.Push(control.text ?? ""))
            
            control.addControlEvent(.editingChanged, { v in
                if let textField = v as? UITextField {
                    talkback?(SinkPayload.Push(textField.text ?? ""))
                }
            })
            
            talkback?(SinkPayload.Start({ t in
                if case SourcePayload.End = t {
                    talkback = nil
                    control.removeControlEvent(.editingChanged)
                }
            }))
        }
        return Callbag<String>(source: source)
    }
}


