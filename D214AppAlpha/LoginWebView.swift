//
//  ViewController.swift
//  D214AppAlpha
//
//  Created by mobileapps on 11/5/15.
//  Copyright © 2015 JohnHerseyHighSchool. All rights reserved.
//

import UIKit

class LoginWebView: UIViewController {

    @IBOutlet weak var LoginWebView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoginWebView.loadRequest(NSURLRequest(URL: NSURL(string: "http://ezproxy.d214.org:2048/login")!))
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let nextPath: MainTableViewController = segue.destinationViewController as! MainTableViewController
      
        nextPath.savedWebView = LoginWebView
    }


}

