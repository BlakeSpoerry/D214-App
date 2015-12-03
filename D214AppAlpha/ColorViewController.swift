//
//  ColorViewController.swift
//  SplitViewControllerDemo
//
//  Created by Natasha Murashev on 10/27/14.
//  Copyright (c) 2014 NatashaTheRobot. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController {

    @IBOutlet weak var splitWebView: UIWebView!
    var bob = Cinfo(cells: SuString(title: "Bing", url: NSURL(string: "http://www.bing.com")!, info: "bing"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = bob.cells.getName()
        splitWebView.loadRequest(NSURLRequest(URL: bob.cells.getURL()))

        
    }

}
