//
//  AlarmController.swift
//  FIT5140A2V2
//
//  Created by duo pan on 19/9/17.
//  Copyright © 2017 duo pan. All rights reserved.
//

import UIKit

protocol addAlarmDelegate {
    func addAlarm(up:Int,low:Int,upMes:String,lowMes:String)
}

class AlarmController: UIViewController, UITextFieldDelegate {
    @IBOutlet var labelUp: UITextField!
    @IBOutlet var labelUpMessage: UITextField!
    @IBOutlet var labelLow: UITextField!
    @IBOutlet var labelLowMessage: UITextField!

    
    var mydelegate : addAlarmDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labelUp.delegate = self
        labelLow.delegate = self
        labelLowMessage.text = ""
        labelUpMessage.text = ""
        labelLow.text = "10"
        labelUp.text = "40"
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveAlarm(_ sender: Any) {
        if labelUp.text == "" || labelLow.text == ""{
            print("no kong")
            return
        }
        if Int(labelUp.text!)! <= Int(labelLow.text!)! {
            print("Upper limit must be larger than lower limit")
            return
        }
        var msg1 = "It is too hot!"
        if labelUpMessage.text != ""{
            msg1 = labelUpMessage.text!
        }
        var msg2 = "It is too cold!"
        if labelLowMessage.text != ""{
            msg2 = labelLowMessage.text!
        }
        self.mydelegate?.addAlarm(up: Int(labelUp.text!)!, low: Int(labelLow.text!)!, upMes: msg1, lowMes: msg2)
        
        self.navigationController?.popViewController(animated: true)
        
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(labelUp == textField || labelLow == textField){
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
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
