//
//  ValidateViewController.swift
//  Callbag_Example
//
//  Created by chuthin on 6/21/18.
//  Copyright © 2018 chuthin. All rights reserved.
//

import Foundation
import UIKit
import Callbag
public class ValidateViewController : UIViewController {
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    public override func viewDidLoad() {
        
        let user = Callbag.textFrom(userName)
        let pass = Callbag.textFrom(password)
        
        Callbag.combineLastest( user,pass, fn: { a, b in
            return (a,b)
        }).map{ !$0.0.isEmpty && !$0.1.isEmpty }
            .forEach{ [weak self] value in
                self?.loginButton.isEnabled = value
        }
        
    }
}
