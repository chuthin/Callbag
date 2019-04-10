//
//  CounterViewController.swift
//  CallbagExample
//
//  Created by chuthin on 4/10/19.
//  Copyright © 2019 chuthin. All rights reserved.
//

import Foundation
import UIKit
import Callbag
import CallbagCocoa
public class CounterViewController : UIViewController {
    @IBOutlet weak var incrementButton: UIButton!
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var counterLabel: UILabel!
    public override func viewDidLoad() {
        super.viewDidLoad()
        let increment = fromEvent(incrementButton, .touchUpInside) *> map { _ in 1}
        let decrement = fromEvent(decrementButton, .touchUpInside) *> map { _ in -1}
        
        merge(increment,decrement)
            *> scan(0){ $0 + $1}
            *> forEach {[weak self] value in
                self?.counterLabel.text = String(value)
        }
        
    }
}
