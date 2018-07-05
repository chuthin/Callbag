//
//  ViewController.swift
//  Callbag
//
//  Created by chuthin on 06/21/2018.
//  Copyright (c) 2018 chuthin. All rights reserved.
//

import UIKit
import Callbag
class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        /*Callbag.fromArray([1,2,3,4,5,6,8])
            .filter{$0 % 2 == 0}
            .map{ $0 * 2}
            .take(2)
            .forEach{ print($0) }*/
        
        Callbag.fromArray([1,2,3,4,5,6,8])
            .map{ $0 * 2}
            .skip(2)
            .take(2)
            .forEach{ print($0) }
        
        print("-----------------------")
        
        Callbag.fromArray([1,2,3,4,5,6,8])
            .map{ $0 * 2}
            .skipUntil{$0 > 6}
            .takeUntil{ $0 < 15}
            .forEach{ print($0) }
        
        print("-----------------------")
        
         Callbag.fromArray([1,2,3,4,5,6,8])
            .scan(0){
                $0 + $1
            }
            .forEach{ print($0) }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

