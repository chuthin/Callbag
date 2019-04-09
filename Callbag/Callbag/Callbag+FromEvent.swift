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
public typealias ControlEvents = UIKit.UIControl.Event
public typealias EventCallback = (Control) -> Void

public func fromEvent(_ control:Control, _ controlEvents:ControlEvents) -> Callbag<Void> {
    return { payload in 
        if case .start(let tb) = payload {
            control.addControlEvent(controlEvents, { _ in
                tb(.data(()))
            })
        }
        else if case .end = payload {
             control.removeControlEvent(controlEvents)
        }
    }
}

public func textFrom(_ control:UITextField) -> Callbag<String> {
    return { payload in
        if case .start(let tb) = payload {
            control.addControlEvent(.editingChanged, { v in
                if let textField = v as? UITextField {
                    tb(.data(textField.text ?? ""))
                }
            })
        }
        else if case .end = payload {
            control.removeControlEvent(.editingChanged)
        }
    }
}
