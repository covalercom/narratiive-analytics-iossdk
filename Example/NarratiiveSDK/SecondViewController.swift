//
//  SecondViewController.swift
//  NarratiiveSDK_Example
//
//  Created by David Lin on 23/6/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import NarratiiveSDK

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let inst = NarratiiveSDK.sharedInstance() {
            inst.send(screenName: "/second-page")
        }
    }
}
