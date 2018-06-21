//
//  ViewController.swift
//  Callbag
//
//  Created by chuthin on 06/21/2018.
//  Copyright (c) 2018 chuthin. All rights reserved.
//

import UIKit
import Callbag
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Callbag.fromArray([1,2,3,4])
            .filter{$0 % 2 == 0}
            .map{ $0 * 2}
            .forEach{ print($0) }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

