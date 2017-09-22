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
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        button1.setImage(#imageLiteral(resourceName: "sensor1"), for: .normal)
        button1.contentMode = .scaleAspectFit
        button2.setImage(#imageLiteral(resourceName: "sensor2"), for: .normal)
        button2.contentMode = .scaleAspectFit
        button3.setImage(#imageLiteral(resourceName: "color1"), for: .normal)
        button3.contentMode = .scaleAspectFit
        button4.setImage(#imageLiteral(resourceName: "color2"), for: .normal)
        button4.contentMode = .scaleAspectFit
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }

}

