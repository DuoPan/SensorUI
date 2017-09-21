//
//  AltitudeController.swift
//  FIT5140A2V2
//
//  Created by duo pan on 14/9/17.
//  Copyright © 2017 duo pan. All rights reserved.
//

import UIKit

class AltitudeController: UIViewController {

    @IBOutlet var labelTop: UILabel!
    @IBOutlet var chartView: Chart!
    @IBOutlet var xTimeLabel: UILabel!
    @IBOutlet var xTimeLabel2: UILabel!
    
    
    var timer = Timer()
    
    var series:ChartSeries?
    var xs:Queue<Float>!
    var ys:Queue<Float>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // downloadWeather()
        xs = Queue<Float>()
        ys = Queue<Float>()
        
        setChart()
        
        scheduledTimerWithTimeInterval()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "currentPageChanged"), object: 2)
    }
    
    
    func setChart()
    {
        series = ChartSeries([0])
        chartView.maxY = 40
        chartView.minY = 0
        chartView.maxX = 6
        chartView.minX = 0
        series?.color = ChartColors.maroonColor()
        var i = 0
        while(i <= 6)
        {
            xs.enqueue(Float(i))
            i += 1
        }
        chartView.showXLabelsAndGrid = false
        ys.enqueue(Float(9))
        ys.enqueue(Float(7))
        ys.enqueue(Float(4))
        ys.enqueue(Float(5))
        ys.enqueue(Float(4))
        ys.enqueue(Float(5))
        ys.enqueue(Float(6))
        
    }
    
    func updateChart()
    {
        var url: URL
        url = URL(string: "http://192.168.1.103:8080/temperature")!
        // fast method to get data
        guard let tempData = NSData(contentsOf: url) else { return }
        let jsonData = JSON(tempData)
        print(jsonData)
        
        chartView.removeAllSeries()
        
        _ = ys.dequeue()
        let altimeter = jsonData["Altimeter"].float!
        ys.enqueue(altimeter)
        let array = ys.toList
        
        self.series?.data = [(0,array[0]),(1, array[1]), (2,array[2]),(3, array[3]),(4,array[4]),(5,array[5]),(6, array[6])]
        
        series?.area = true
        chartView.add(series!)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm:ss"
        let nowtime = NSDate()
        xTimeLabel.text = dateFormatter.string(from: nowtime as Date)
        let time2 = NSDate().addingTimeInterval(-3)
        xTimeLabel2.text = dateFormatter.string(from: time2 as Date)
        
    }
    
    func checkInitStatus() -> Bool {
        return self.chartView != nil
    }
    
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.updateChart), userInfo: nil, repeats: true)
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
