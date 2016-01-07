//
//  CiteViewController.swift
//  D214AppAlpha
//
//  Created by mobileapps on 12/3/15.
//  Copyright © 2015 JohnHerseyHighSchool. All rights reserved.
//

import UIKit

class SiteViewController: UIViewController{

    @IBOutlet weak var WebSiteView: UIWebView!
    
    var loadThisSite = SuString(title: "Jhhs", url: NSURL(string: "http://jhhs.d214.org/")!, info: "School")
    //var firstload = true
    override func viewDidLoad() {
        super.viewDidLoad()
        /*if(firstload){
            WebSiteView.alpha = 0.0
            firstload = false
        }
        */
        WebSiteView.loadRequest(NSURLRequest(URL: (loadThisSite.getURL())))
    
}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}