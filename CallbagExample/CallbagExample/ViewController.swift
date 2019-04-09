//
//  ViewController.swift
//  CallbagExample
//
//  Created by chuthin on 4/9/19.
//  Copyright © 2019 chuthin. All rights reserved.
//

import UIKit
import Callbag
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fromArray([1,2,3,4,5,6,7,8,9])
            ~> filter{ $0 % 2 == 0}
            ~> map { $0 * 2}
            ~> forEach{ print($0)}
    }


}

