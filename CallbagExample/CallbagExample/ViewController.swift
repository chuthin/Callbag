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
            => flatmap{ value -> Producer<Int> in
                return fromArray(value)
            }
            // => filter {$0 % 2 != 0}
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
        r1() // r1 dispose()
        subject(.data(21))
        r2() // r2 dispose()
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
        subject2(.data(5))

        
        let _ = fromArray([1,2,3,3,2,3,6,6])
        => distinctUntilChanged()
        => subscribe(onData: {
            print($0)
        })

        let _ = speedTimer()
            => subscribeWithPushback(onData: { value, talkback in
                print(value)
                if value == 10 {
                    talkback?(SpeedLevel.med)
                } else if value == 15 {
                    talkback?(SpeedLevel.max)
                } else if value == 20 {
                    talkback?(SpeedLevel.min)
                } else if value == 30 {
                    talkback?(nil)
                }
            }, oneEnd: { _ in
                print("End")
            })
    }




    public func speedTimer() -> Producer<Int> {
        return { sink in
            var timer: Timer?
            var i: Int = 0;
            var speed = SpeedLevel.min

            let block : (Timer) -> Void = { _ in
                sink(.data(i));
                i += 1;
            }

            sink(.start({ payload in
                if let value = payload as? SpeedLevel {
                    speed = value
                    timer?.invalidate()
                    timer = nil
                    timer = Timer.scheduledTimer(withTimeInterval: speed.rawValue, repeats: true, block: block)
                } else {
                    timer?.invalidate()
                    timer = nil
                    sink(.end(nil))
                }
            }))

            timer = Timer.scheduledTimer(withTimeInterval: speed.rawValue, repeats: true, block: block)
        }
    }

    public enum SpeedLevel: TimeInterval {
        case min = 1
        case med = 2
        case max = 3
    }

}
