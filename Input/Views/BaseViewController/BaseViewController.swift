//
//  BaseViewController.swift
//  Input
//
//  Created by IVC on 3/29/19.
//  Copyright © 2019 jz. All rights reserved.
//

import UIKit

protocol BaseViewControllerProtocol {
    // Use for all view controller protocol as super class
    func showAlertMessage(msg: String)
    func update()
}

class BaseViewController: UIViewController, BaseViewControllerProtocol {
    func showAlertMessage(msg: String) {
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func update() {
        //
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
