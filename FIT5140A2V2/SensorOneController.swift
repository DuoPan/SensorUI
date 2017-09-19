//
//  SensorOneController.swift
//  FIT5140A2V2
//
//  Created by duo pan on 14/9/17.
//  Copyright © 2017 duo pan. All rights reserved.
//
// tutorial : http://www.jianshu.com/p/807dadec8559



import UIKit

class SensorOneController: UIViewController,UIPageViewControllerDataSource {

    var pageViewController: UIPageViewController!
    
    var pressureController: PressureController!
    var altitudeController: AltitudeController!
    var temperatureController: CurrentWeatherController!
    
    var controllers = [UIViewController]()
    
    @IBOutlet var indicateView: UIView!
    var indicateImageView: UIImageView!
    
    var lastPage = 0
    var currentPage: Int = 0 {
        didSet {
            let offset = self.view.frame.width / 3.0 * CGFloat(currentPage)
            UIView.animate(withDuration: 0.3) { () -> Void in
                self.indicateImageView.frame.origin = CGPoint(x: offset, y: -1)
            }
            
            if currentPage > lastPage {
                self.pageViewController.setViewControllers([controllers[currentPage]], direction: .forward, animated: true, completion: nil)
            }
            else {
                self.pageViewController.setViewControllers([controllers[currentPage]], direction: .reverse, animated: true, completion: nil)
            }
            
            lastPage = currentPage
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pageViewController = self.childViewControllers.first as! UIPageViewController
        pressureController = storyboard?.instantiateViewController(withIdentifier: "pressureid") as! PressureController
        altitudeController = storyboard?.instantiateViewController(withIdentifier: "altitudeid") as! AltitudeController
        temperatureController = storyboard?.instantiateViewController(withIdentifier: "temperatureid") as! CurrentWeatherController
        
        pageViewController.dataSource = self
        pageViewController.setViewControllers([temperatureController], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        
        indicateImageView = UIImageView(frame: CGRect(x: 0, y: -1, width: self.view.frame.width / 3.0, height: 3.0))
        indicateImageView.image = UIImage(named: "zhishi")
        indicateView.addSubview(indicateImageView)
        
        controllers.append(temperatureController)
        controllers.append(pressureController)
        controllers.append(altitudeController)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.currentPageChanged(notification:)), name: NSNotification.Name(rawValue: "currentPageChanged"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if viewController.isKind(of: CurrentWeatherController.self) {
            return pressureController
        }
        else if viewController.isKind(of: PressureController.self) {
            return altitudeController
        }
        else if viewController.isKind(of: AltitudeController.self) {
            return temperatureController
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if viewController.isKind(of: CurrentWeatherController.self) {
            return altitudeController
        }
        else if viewController.isKind(of: PressureController.self) {
            return temperatureController
        }
        else if viewController.isKind(of: AltitudeController.self) {
            return pressureController
        }
        return nil
    }
    
    @IBAction func changePage(_ sender: UIButton) {
        currentPage = sender.tag - 100
    }
    
 
    
    func currentPageChanged(notification: NSNotification) {
        currentPage = notification.object as! Int
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

