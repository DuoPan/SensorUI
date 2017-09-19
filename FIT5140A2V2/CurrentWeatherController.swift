//
//  CurrentWeatherController.swift
//  FIT5140A2V2
//
//  Created by duo pan on 12/9/17.
//  Copyright © 2017 duo pan. All rights reserved.
//

// Use external package to handle json
// reference: https://github.com/SwiftyJSON/SwiftyJSON

// line chart
// reference:https://github.com/gpbl/SwiftChart

// queue data structure
// reference: https://github.com/raywenderlich/swift-algorithm-club/tree/master/Queue

import UIKit

class CurrentWeatherController: UIViewController, addAlarmDelegate {

    @IBOutlet var labelTest: UILabel!
    @IBOutlet var chartView: Chart!
    @IBOutlet var xTimeLabel: UILabel!
    @IBOutlet var xTimeLabel2: UILabel!
    
    var timer = Timer()
    
    // can be a class if we have time
    var upper = 0, lower = 0
    var upmsg = "", lowmsg = ""
    var isAlarm = false
  
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
        // Dispose of any resources that can be recreated.
    }
    
    func downloadWeather() {
        var url: URL
        url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=beijing&units=metric&appid=12b2817fbec86915a6e9b4dbbd3d9036")!
        
        // fast method to get data
        guard let weatherData = NSData(contentsOf: url) else { return }
        let jsonData = JSON(weatherData)
        labelTest.text = "城市：\(jsonData["name"].string!)"
        
        // slow method to get data
        //        let task = URLSession.shared.dataTask(with: url) { data, response, error in
        //            if(error != nil) {
        //                print("URL Error has occured: \(error)")
        //            } else {
        //                let jsonData = JSON(data)
        //                self.labelTest.text = "城市：\(jsonData["name"].string!)"
        //            }
        //        }
        //        task.resume()
    }

    func setChart()
    {
        series = ChartSeries([0])
        chartView.maxY = 10
        chartView.minY = 0
        chartView.maxX = 6
        chartView.minX = 0
        series?.color = ChartColors.greenColor()
        var i = 0
        while(i <= 6)
        {
            xs.enqueue(Float(i))
            i += 1
        }
        chartView.showXLabelsAndGrid = false
        ys.enqueue(Float(6))
        ys.enqueue(Float(7))
        ys.enqueue(Float(6))
        ys.enqueue(Float(5))
        ys.enqueue(Float(4))
        ys.enqueue(Float(5))
        ys.enqueue(Float(6))
        
    }
    
    func updateChart()
    {
        chartView.removeAllSeries()
        
        let fir = ys.dequeue()
        ys.enqueue(fir!)
        let arrayy = ys.toList
        
        self.series?.data = [(0,arrayy[0]),(1, arrayy[1]), (2,arrayy[2]),(3, arrayy[3]),(4,arrayy[4]),(5,arrayy[5]),(6, arrayy[6])]
        
        series?.area = true
        chartView.add(series!)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm:ss"
        let nowtime = NSDate()
        xTimeLabel.text = dateFormatter.string(from: nowtime as Date)
        let time2 = NSDate().addingTimeInterval(-3)
        xTimeLabel2.text = dateFormatter.string(from: time2 as Date)
        
        if isAlarm == true {
            runAlarm(curTem: arrayy[6])
        }
        
     
    }
    
    func runAlarm(curTem:Float)
    {
        if curTem >= Float(upper) {
            showMsg(msg: upmsg)
            isAlarm = false
        }
        else if curTem <= Float(lower) {
            showMsg(msg: lowmsg)
            isAlarm = false
        }
    }
    
    func showMsg(msg:String){
        let alertController = UIAlertController(title: msg, message: nil, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            self.presentedViewController?.dismiss(animated: false, completion: nil)
        }
    }
    
    
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateChart), userInfo: nil, repeats: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "currentPageChanged"), object: 0)
    }
 
    func addAlarm(up:Int,low:Int,upMes:String,lowMes:String)
    {
        upper = up
        lower = low
        upmsg = upMes
        lowmsg = lowMes
        isAlarm = true
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
