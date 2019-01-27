//
//  ViewController.swift
//  SSFlipViewController
//
//  Created by sestinj on 01/25/2019.
//  Copyright (c) 2019 sestinj. All rights reserved.
//

import UIKit
import SSFlipViewController

class ViewController: UIViewController, SSFlipViewControllerDelegate {
    func didFlip(flipVC: SSFlipViewController) {
        print("So flippin' cool!!!")
    }
    
    var flipVC: SSFlipViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let front = FrontViewController()
        let back = BackViewController()
        flipVC = SSFlipViewController(front: front, back: back)
        flipVC.delegate = self
        addChild(flipVC)
        view.addSubview(flipVC.view)
    }

}
