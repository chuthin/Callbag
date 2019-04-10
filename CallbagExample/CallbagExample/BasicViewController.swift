//
//  BasicViewController.swift
//  CallbagExample
//
//  Created by chuthin on 4/10/19.
//  Copyright © 2019 chuthin. All rights reserved.
//

import Foundation
import UIKit
import Callbag
public class BasicViewController : UIViewController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        /*-------------------------*/
        fromArray([1,2,3,4,5,6,7,8,9]) // 1, 2, 3, 4, 5, 6, 7, 8, 9,
            *> filter{ $0 % 2 == 0}    // 2, 4, 6, 8
            *> map { $0 * 2}           // 4, 8, 12, 16
            *> forEach{ print($0)}
        
        //4
        //8
        //12
        //16
        
        /*--------------------------*/
        fromInterval(1)
            *> map{ $0 + 1}
            *> filter{ $0 % 2 != 0}
            *> take(5)
            *> forEach{ print($0)}
        //1
        //3
        //5
        //7
        //9
    }
}
