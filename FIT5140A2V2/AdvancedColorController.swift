//
//  AdvancedColorController.swift
//  FIT5140A2V2
//
//  Created by duo pan on 20/9/17.
//  Copyright © 2017 duo pan. All rights reserved.
//

import UIKit

class AdvancedColorController: UITableViewController {

    var rows = 4
    var colorList:[UIColor] = []
    
    @IBOutlet var result1: UIView!
    
    
    @IBOutlet var result2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //colorList?.append(UIColor.gray)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "advancedColorCell", for: indexPath) as! ColorCell

        colorList.append(cell.colorView.backgroundColor!)
        
        let i = indexPath.row
        cell.labelName.text = "Color " + String(i + 1)

        // final loop do merge color
        if i == rows - 1
        {
            mergeColor()
        }
        return cell
    }
    
    @IBAction func addColorCell(_ sender: Any) {
        rows += 1
        self.colorList.removeAll()
        self.tableView.reloadData()
    }

    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // left split each cell
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let actionDel = UITableViewRowAction(style: .destructive, title: "Delete") { (_, indexPath) in
            
            self.rows -= 1
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.colorList.remove(at: indexPath.row)
            self.mergeColor()
        }
        
        // when click edit button, get data from sensor
        let actionEdit = UITableViewRowAction(style: .default, title: "Scan Color") { (_, _) in
            // do scan color
            let cell = tableView.cellForRow(at: indexPath) as! ColorCell
            cell.colorView.backgroundColor = self.download()
            self.colorList.remove(at: indexPath.row)
            self.colorList.insert(cell.colorView.backgroundColor!, at: indexPath.row)
            self.mergeColor()
            
      
        }
        actionEdit.backgroundColor = UIColor.orange
        
        return [actionDel, actionEdit]
    }
    

    func download() -> UIColor
    {
        var url: URL
        url = URL(string: "http://192.168.1.103:8080/scanColor")!
        
        guard let weatherData = NSData(contentsOf: url) else { return UIColor.darkGray}
        var colorData = JSON(weatherData)[0]
        print(colorData)
        //        var range = self.highestRgb - self.lowestRgb
        
        let red: Float = colorData["Red"].float! / 300
        let green: Float = colorData["Green"].float! / 300
        let blue: Float = colorData["Blue"].float! / 300
        
        
        let scanedColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1)
        
//        return UIColor.red
        return scanedColor
    }
    
    func mergeColor()
    {
        // result 1
        var r:CGFloat = 0.0
        var g:CGFloat = 0.0
        var b:CGFloat = 0.0
        
        for c in colorList
        {
            let rgb = c.cgColor.components
            r += (rgb?[0])!
            g += (rgb?[1])!
            b += (rgb?[2])!
        }
        
        r /= CGFloat(colorList.count)
        g /= CGFloat(colorList.count)
        b /= CGFloat(colorList.count)
        
        result1.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        
        
        // result 2
        
        self.result2.layer.sublayers = nil
        var gradientColors:[CGColor] = []
        for c in colorList
        {
            gradientColors.append(c.cgColor)
        }
        
        //create CAGradientLayer
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        // set horizontal
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        //set CAGradientLayer frame
        gradientLayer.frame = self.result2.bounds
        self.result2.layer.addSublayer(gradientLayer)
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
