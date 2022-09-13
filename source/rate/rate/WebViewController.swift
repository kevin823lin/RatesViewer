//
//  WebViewController.swift
//  rate
//
//  Created by kevin on 2019/11/12.
//  Copyright © 2019 kevin. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    var url : String = ""
    var mytitle = "歷史匯率"
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet  var lable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = mytitle
        
        let request = URLRequest(url: URL(string: url)!)
        webView?.load(request)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
