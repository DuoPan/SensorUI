//
//  ColorController.swift
//  FIT5140A2V2
//
//  Created by duo pan on 19/9/17.
//  Copyright © 2017 duo pan. All rights reserved.
//

// Alpha = 0.5  (1~50)

import UIKit

class ColorController: UIViewController {

    @IBOutlet var colorView1: UIView!
    @IBOutlet var colorView2: UIView!
    
    @IBOutlet var colorResult: UIView!
    @IBOutlet var colorResult2: UIView!
    
    @IBOutlet var btn1: UIButton!
    @IBOutlet var btn2: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btn1.layer.cornerRadius = 5
        btn1.layer.borderWidth = 1
        btn1.layer.borderColor = UIColor.black.cgColor
        btn2.layer.cornerRadius = 5
        btn2.layer.borderWidth = 1
        btn2.layer.borderColor = UIColor.black.cgColor
        
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
   
    }
    
    @IBAction func readColor1(_ sender: Any) {
        // get color
        // download()
        colorView1.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        mergeColor()
    }

    @IBAction func readColor2(_ sender: Any) {
        colorView2.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1)
        mergeColor()
    }
    
    func mergeColor()
    {
        let rgb1 = colorView1.backgroundColor!.cgColor.components
        let red1 = rgb1?[0], green1 = rgb1?[1], blue1 = rgb1?[2]
        
        let rgb2 = colorView2.backgroundColor!.cgColor.components
        let red2 = rgb2?[0], green2 = rgb2?[1], blue2 = rgb2?[2]
        
        // result view 1
        
        let red3 = red1! * 0.5 + red2! * 0.5
        let green3 = green1! * 0.5 + green2! * 0.5
        let blue3 = blue1! * 0.5 + blue2! * 0.5
        colorResult.backgroundColor = UIColor(red: red3, green: green3, blue: blue3, alpha: 1)
        
        //test
//        print("r "+String(describing: red3))
//        print("g "+String(describing: green3))
//        print("b "+String(describing: blue3))
        
        // result view 2

        // remove other sublayers
        self.colorResult2.layer.sublayers = nil
        
        let gradientColors = [colorView1.backgroundColor!.cgColor, colorView2.backgroundColor!.cgColor]
        
        //create CAGradientLayer
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        // set horizontal
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        //set CAGradientLayer frame
        gradientLayer.frame = self.colorResult2.bounds
        self.colorResult2.layer.addSublayer(gradientLayer)
        
   
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
