//
//  LoginViewController.swift
//  CallbagExample
//
//  Created by chuthin on 4/10/19.
//  Copyright © 2019 chuthin. All rights reserved.
//

import Foundation
import UIKit
import Callbag
import CallbagCocoa
public class LoginViewController : UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        let username = textFrom(usernameTextField) *> startWith("")
        let password = textFrom(passwordTextField) *> startWith("")
        
        combineLastest(username, password) { username, password -> Bool in
                !username.isEmpty && !password.isEmpty
            }
            *> forEach{[weak self] value in
                self?.loginButton.isEnabled = value
            }
        
    }
}
