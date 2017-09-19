//
//  ViewController.swift
//  FIT5140A2V2
//
//  Created by duo pan on 12/9/17.
//  Copyright © 2017 duo pan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        button1.setImage(#imageLiteral(resourceName: "sensor1"), for: .normal)
        button1.contentMode = .scaleAspectFit
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }

}

