//
//  ViewController.swift
//  CallbagExample
//
//  Created by Chu Thin on 7/31/20.
//  Copyright © 2020 Chu Thin. All rights reserved.
//

import UIKit
import Callbag
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let _ = fromArray([1,2,3])
            => filter {$0 % 2 != 0}
            => map {$0 * 2}
            => subscribe(onData: {
                print($0)
            })
        print("------------------")
        let _ = fromArray([[1,2,3,4],[2,3,5,8]])
            => flatmap{ value -> Source<Int> in
                return fromArray(value)
            }
            => filter {$0 % 2 != 0}
            => map {$0 * 2}
            => subscribe(onData: {
                print($0)
            })
        print("------------------")
        let subject:Subject<Int> = makeSubject()
        let r1 = fromSubject(subject)
            => subscribe(onData: {
                
                print("r1: \($0)")
            })
        
        let r2 = fromSubject(subject)
            => subscribe(onData: {
                print("r2: \($0)")
            })
        
        subject(.data(10))
        r1()
        subject(.data(21))
        r2()
        subject(.data(22))
        
        print("------------------")
        let subject2 = makeReplaySubject(2)
        let _ = fromSubject(subject2)
            => subscribe(onData: {
                print("r3 \($0)")
            })
        subject2(.data(3))
        
        let _ = fromSubject(subject2)
            => subscribe(onData: {
                print("r4 \($0)")
            })
        
        subject2(.data(4))
        
    }
}

