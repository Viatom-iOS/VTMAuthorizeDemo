//
//  ViewController.swift
//  VTMAuthorizeDemo
//
//  Created by yangweichao on 2022/12/12.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func toAuthorize(_ sender: UIButton) {
        
        let vc = AuthorizeViewController.init()
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

