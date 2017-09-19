//
//  WebController.swift
//  FIT5140A2V2
//
//  Created by duo pan on 12/9/17.
//  Copyright © 2017 duo pan. All rights reserved.
//

import UIKit

class WebController: UIViewController {

    @IBOutlet var viewWeb: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "http://www.baidu.com")
        if let unwrappedURL = url{
            let request = URLRequest(url: unwrappedURL)
            let session = URLSession.shared
            let task = session.dataTask(with: request){(data, response, error) in
                if error == nil{ self.viewWeb.loadRequest(request)}
                else{print("error happened")}
            }
            task.resume()
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
