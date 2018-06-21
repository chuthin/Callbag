//
//  CounterViewController.swift
//  Callbag_Example
//
//  Created by chuthin on 6/21/18.
//  Copyright © 2018 chuthin. All rights reserved.
//

import Foundation
import UIKit
import Callbag
public class CounterViewController : UIViewController {
    @IBOutlet weak var increButton: UIButton!
    @IBOutlet weak var decreButton: UIButton!
    
    
    @IBOutlet weak var counterLabel: UILabel!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let incre = Callbag.fromEvent(increButton, .touchUpInside)
            .map{_ in 1}
        let decre = Callbag.fromEvent(decreButton, .touchUpInside)
            .map{_ in -1}
        var counter = 0
        Callbag.merge(incre,decre)
            .forEach{ [weak self] value in
                counter += value
                self?.counterLabel.text = "\(counter)"
            }
        
        
    }
}
