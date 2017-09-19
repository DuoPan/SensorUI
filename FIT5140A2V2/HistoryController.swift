//
//  HistoryController.swift
//  FIT5140A2V2
//
//  Created by duo pan on 18/9/17.
//  Copyright © 2017 duo pan. All rights reserved.
//

import UIKit
import DLRadioButton

class HistoryController: UITableViewController, UITextFieldDelegate {
    
    var historicalData:JSON?
    var rowNumber:Int = 0 // size of array, should set max number
    
    @IBOutlet var btnA1: DLRadioButton!
    @IBOutlet var btnA2: DLRadioButton!
    @IBOutlet var btnA3: DLRadioButton!
    
    var flag = 3 // default show all attributes
    
    @IBOutlet var labelStatis: UILabel!  // calculate labelStatis in draw table process
    
    var max1 = 0.0, min1 = 9999.0, avg1 = 0.0, sum1 = 0.0
    var max2 = 0.0, min2 = 9999.0, avg2 = 0.0, sum2 = 0.0
    var max3 = 0.0, min3 = 9999.0, avg3 = 0.0, sum3 = 0.0
    
    @IBOutlet var textNumber: UITextField! // number of data set
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnA1.isMultipleSelectionEnabled = true;
        self.btnA1.isSelected = true;
        self.btnA2.isMultipleSelectionEnabled = true;
        self.btnA2.isSelected = true;
        self.btnA3.isMultipleSelectionEnabled = true;
        self.btnA3.isSelected = true;
        
        self.textNumber.delegate = self
        
        download()
        showAttribute("show statis")
        
    }
    
    func download()
    {
        var url: URL
        url = URL(string: "https://duopan.github.io")!
        
        guard let weatherData = NSData(contentsOf: url) else { return }
        self.historicalData = JSON(weatherData)
        self.rowNumber = (self.historicalData?.array?.count)!
        
     //default show all data
        self.textNumber.text = String(self.rowNumber) // max is 100, default is 100
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.rowNumber * flag
    }
    
    
    // consider to add format to show data
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryCell
      
        // case 1 show all attributes
        if self.flag == 3
        {
            let i = indexPath.row
            
            if i % 3 == 0
            {
                cell.labelName.text = "Celsius"
                cell.labelValue.text = String (describing: (historicalData?.array?[i/3]["wendu"])!)
                sum1 += Double(cell.labelValue.text!)!
                if (Double(cell.labelValue.text!)! > max1) {
                    max1 = Double(cell.labelValue.text!)!
                }
                if (Double(cell.labelValue.text!)! < min1) {
                    min1 = Double(cell.labelValue.text!)!
                }
            }
            else if i % 3 == 1{
                cell.labelName.text = "Pressure"
                cell.labelValue.text = String (describing: (historicalData?.array?[i/3]["pres"])!)
                sum2 += Double(cell.labelValue.text!)!
                if (Double(cell.labelValue.text!)! > max2) {
                    max2 = Double(cell.labelValue.text!)!
                }
                if (Double(cell.labelValue.text!)! < min2) {
                    min2 = Double(cell.labelValue.text!)!
                }
            }
            else if i % 3 == 2{
                cell.labelName.text = "Altitude"
                cell.labelValue.text = String (describing: (historicalData?.array?[i/3]["haiba"])!)
                sum3 += Double(cell.labelValue.text!)!
                if (Double(cell.labelValue.text!)! > max3) {
                    max3 = Double(cell.labelValue.text!)!
                }
                if (Double(cell.labelValue.text!)! < min3) {
                    min3 = Double(cell.labelValue.text!)!
                }
            }
            cell.labelTime.text = String (describing: (historicalData?.array?[i/3]["time"])!)
            
       
            
            
        }
            // case 2 hide one attribute
        else if self.flag == 2 {
            if btnA1.isSelected == false{
                let i = indexPath.row
                if i % 2 == 0 {
                    cell.labelName.text = "Pressure"
                    cell.labelValue.text = String (describing: (historicalData?.array?[i/2]["pres"])!)
                    sum2 += Double(cell.labelValue.text!)!
                    if (Double(cell.labelValue.text!)! > max2) {
                        max2 = Double(cell.labelValue.text!)!
                    }
                    if (Double(cell.labelValue.text!)! < min2) {
                        min2 = Double(cell.labelValue.text!)!
                    }
                }
                else if i % 2 == 1{
                    cell.labelName.text = "Altitude"
                    cell.labelValue.text = String (describing: (historicalData?.array?[i/2]["haiba"])!)
                    sum3 += Double(cell.labelValue.text!)!
                    if (Double(cell.labelValue.text!)! > max3) {
                        max3 = Double(cell.labelValue.text!)!
                    }
                    if (Double(cell.labelValue.text!)! < min3) {
                        min3 = Double(cell.labelValue.text!)!
                    }
                }
                cell.labelTime.text = String (describing: (historicalData?.array?[i/2]["time"])!)
                
            }
            else if btnA2.isSelected == false{
                let i = indexPath.row
                
                if i % 2 == 0 {
                    cell.labelName.text = "Celsius"
                    cell.labelValue.text = String (describing: (historicalData?.array?[i/2]["wendu"])!)
                    sum1 += Double(cell.labelValue.text!)!
                    if (Double(cell.labelValue.text!)! > max1) {
                        max1 = Double(cell.labelValue.text!)!
                    }
                    if (Double(cell.labelValue.text!)! < min1) {
                        min1 = Double(cell.labelValue.text!)!
                    }
                }
                else if i % 2 == 1{
                    cell.labelName.text = "Altitude"
                    cell.labelValue.text = String (describing: (historicalData?.array?[i/2]["haiba"])!)
                    sum3 += Double(cell.labelValue.text!)!
                    if (Double(cell.labelValue.text!)! > max3) {
                        max3 = Double(cell.labelValue.text!)!
                    }
                    if (Double(cell.labelValue.text!)! < min3) {
                        min3 = Double(cell.labelValue.text!)!
                    }
                }
                cell.labelTime.text = String (describing: (historicalData?.array?[i/2]["time"])!)
                
            }
            else{
                let i = indexPath.row
                if i % 2 == 0 {
                    cell.labelName.text = "Celsius"
                    cell.labelValue.text = String (describing: (historicalData?.array?[i/2]["wendu"])!)
                    sum1 += Double(cell.labelValue.text!)!
                    if (Double(cell.labelValue.text!)! > max1) {
                        max1 = Double(cell.labelValue.text!)!
                    }
                    if (Double(cell.labelValue.text!)! < min1) {
                        min1 = Double(cell.labelValue.text!)!
                    }
                }
                else if i % 2 == 1{
                    cell.labelName.text = "Pressure"
                    cell.labelValue.text = String (describing: (historicalData?.array?[i/2]["pres"])!)
                    sum2 += Double(cell.labelValue.text!)!
                    if (Double(cell.labelValue.text!)! > max2) {
                        max2 = Double(cell.labelValue.text!)!
                    }
                    if (Double(cell.labelValue.text!)! < min2) {
                        min2 = Double(cell.labelValue.text!)!
                    }
                }
                cell.labelTime.text = String (describing: (historicalData?.array?[i/2]["time"])!)
            }
            
        }
            //case 3 show only one
        else if self.flag == 1 {
            if btnA1.isSelected == true{
                let i = indexPath.row
                cell.labelName.text = "Celsius"
                cell.labelValue.text = String (describing: (historicalData?.array?[i]["wendu"])!)
                cell.labelTime.text = String (describing: (historicalData?.array?[i]["time"])!)
                sum1 += Double(cell.labelValue.text!)!
                if (Double(cell.labelValue.text!)! > max1) {
                    max1 = Double(cell.labelValue.text!)!
                }
                if (Double(cell.labelValue.text!)! < min1) {
                    min1 = Double(cell.labelValue.text!)!
                }
            }
            else if btnA2.isSelected == true{
                let i = indexPath.row
                cell.labelName.text = "Pressure"
                cell.labelValue.text = String (describing: (historicalData?.array?[i]["pres"])!)
                cell.labelTime.text = String (describing: (historicalData?.array?[i]["time"])!)
                sum2 += Double(cell.labelValue.text!)!
                if (Double(cell.labelValue.text!)! > max2) {
                    max2 = Double(cell.labelValue.text!)!
                }
                if (Double(cell.labelValue.text!)! < min2) {
                    min2 = Double(cell.labelValue.text!)!
                }
            }
            else{
                let i = indexPath.row
                cell.labelName.text = "Altitude"
                cell.labelValue.text = String (describing: (historicalData?.array?[i]["haiba"])!)
                cell.labelTime.text = String (describing: (historicalData?.array?[i]["time"])!)
                sum3 += Double(cell.labelValue.text!)!
                if (Double(cell.labelValue.text!)! > max3) {
                    max3 = Double(cell.labelValue.text!)!
                }
                if (Double(cell.labelValue.text!)! < min3) {
                    min3 = Double(cell.labelValue.text!)!
                }
            }
        }
  
        // if cell count is 0, it will not be executed
        // only call once
        if indexPath.row == self.rowNumber * flag - 1{
            setStatis()
        }
        
        return cell
    }
    
    
    // click button
    @IBAction func showAttribute(_ sender: Any) {
        var rows = 0;
        if(btnA1.isSelected == true){
            rows += 1
        }
        if(btnA2.isSelected == true){
            rows += 1
        }
        if(btnA3.isSelected == true){
            rows += 1
        }
        self.flag = rows
        
        initStatic()
        self.tableView.reloadData()
        if flag == 0 {
            setStatis()
        }
    }

    func setStatis()
    {
        avg1 = sum1 / Double(rowNumber)
        avg2 = sum2 / Double(rowNumber)
        avg3 = sum3 / Double(rowNumber)
        if flag == 3 {
            // seems that nsstring can only accept 8 parameters......
            labelStatis.text = NSString(format: " Celsius: Avg %.2f, Max %.2f, Min %.2f \n Pressure: Avg %.2f, Max %.2f, Min %.2f \n Altitude: Avg %.2f, Max %.2f", avg1, max1, min1,avg2, max2, min2,avg3, max3) as String
            labelStatis.text?.append(NSString(format: "Min %.2f", min3) as String)
        }
        else if flag == 2{
            if btnA1.isSelected == false{
                labelStatis.text = NSString(format: "Pressure: Avg %.2f, Max %.2f, Min %.2f \n Altitude: Avg %.2f, Max %.2f, Min %.2f ",avg2, max2, min2,avg3, max3,min3) as String
            }
            else if btnA2.isSelected == false{
                labelStatis.text = NSString(format: "Celsius: Avg %.2f, Max %.2f, Min %.2f \n Altitude: Avg %.2f, Max %.2f, Min %.2f ",avg1, max1, min1,avg3, max3,min3) as String
            }
            else{
                labelStatis.text = NSString(format: "Celsius: Avg %.2f, Max %.2f, Min %.2f \n Pressure: Avg %.2f, Max %.2f, Min %.2f ",avg1, max1, min1,avg2, max2,min2) as String
            }
        }
        else if flag == 1{
            if btnA1.isSelected == true {
                labelStatis.text = NSString(format: "Celsius: Avg %.2f, Max %.2f, Min %.2f",avg1, max1, min1) as String
            }
            else if btnA2.isSelected == true{
                labelStatis.text = NSString(format: "Pressure: Avg %.2f, Max %.2f, Min %.2f",avg1, max1, min1) as String
            }
            else{
                labelStatis.text = NSString(format: "Altitude: Avg %.2f, Max %.2f, Min %.2f",avg1, max1, min1) as String
            }
        }
        else if flag == 0{
            labelStatis.text = "Please choose attributes"
        }
    }
    
    func initStatic(){
        max1 = 0.0
        min1 = 9999.0
        avg1 = 0.0
        sum1 = 0.0
        max2 = 0.0
        min2 = 9999.0
        avg2 = 0.0
        sum2 = 0.0
        max3 = 0.0
        min3 = 9999.0
        avg3 = 0.0
        sum3 = 0.0
    }
    
    @IBAction func applyNumber(_ sender: Any) {
        if (Int(textNumber.text!)! > 1000)
        {
            let alert = UIAlertController(title: "Warning", message: "Can not over 1000", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            textNumber.text = "1000"
        }
        else{// if there is enough data
            if Int(textNumber.text!)! > (self.historicalData?.array?.count)!
            {
                let alert = UIAlertController(title: "Warning", message: "Do not contain too much data, will display all data", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.rowNumber = (self.historicalData?.array?.count)!
            }
            else
            {
                self.rowNumber = Int(textNumber.text!)!
            }
            initStatic()
            self.tableView.reloadData()
            if flag == 0 {
                setStatis()
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
