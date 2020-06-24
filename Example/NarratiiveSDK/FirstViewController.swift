//
//  ViewController.swift
//  NarratiiveSDK
//
//  Created by git on 06/23/2020.
//  Copyright (c) 2020 git. All rights reserved.
//

import UIKit
import NarratiiveSDK

class FirstViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if let inst = NarratiiveSDK.sharedInstance() {
            inst.send(screenName: "/first-page")
        }
    }
}

