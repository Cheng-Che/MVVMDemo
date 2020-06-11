//
//  ViewController.swift
//  MVVMDemo
//
//  Created by Steven Hsieh on 2020/6/4.
//  Copyright © 2020 Steven Hsieh. All rights reserved.
//

import UIKit

let screenValue = UIScreen.main.bounds

class ViewController: UIViewController {

    @IBAction func mainBtnClicked(_ sender: UIButton) {
        let vc: PhotoViewController = PhotoViewController(nibName: "PhotoViewController", bundle: Bundle.main)
        navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Main View"
    }


}

