//
//  SelectCiteViewController.swift
//  D214AppAlpha
//
//  Created by mobileapps on 12/3/15.
//  Copyright © 2015 JohnHerseyHighSchool. All rights reserved.
//

import UIKit

class SelectSiteTableViewController: UITableViewController {
    
    @IBOutlet var WebsiteTableView: UITableView!
    
    var sectionidentifier: String?
    
    var WebSiteList: [SuString]?
    
    var savedSplitWebView: UIWebView?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        WebSiteList = getWebList(sectionidentifier!)
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (WebSiteList)!.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("WebsiteCell", forIndexPath: indexPath)
        cell.textLabel?.text = WebSiteList![indexPath.row].getName()
        
        return cell
    }
    
    // MARK: Table View Delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       // performSegueWithIdentifier("show_detail_segue_id", sender: indexPath)
        
    }
    
    func getWebList(filename: String) -> [SuString]{
        var list = [SuString]()
        if let path = NSBundle.mainBundle().pathForResource(filename, ofType: "txt"){
            
            let data = try? String(contentsOfFile:path, encoding: NSUTF8StringEncoding)
            if let content = (data){
                let myStrings = content.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
                for i in 0...myStrings.count-1{
                    let section = myStrings[i].componentsSeparatedByString(",")
                    list.append(SuString(title: section[0], url: NSURL(string: section[1])!, info: section[2]))
                }
            }
        }
        return list
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if segue.identifier == "show_detail_segue_id" {
            
            var siteViewController: SiteViewController!
            
            // code needed to support all devices
            if let siteNavigationController = segue.destinationViewController as? UINavigationController {
                
                // works on devices where UISplitViewController is implemented
                siteViewController = siteNavigationController.topViewController as! SiteViewController
                siteViewController.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                siteViewController.navigationItem.leftItemsSupplementBackButton = true
            } else {
                
                // works for iPhone on ios7, where UISplitViewController is not implemented
                siteViewController = segue.destinationViewController as! SiteViewController
            }
            // This sends the URL to the webview and passes the UIWebView with login info with it
            // Apples Split Web View handles the NextPath
            if let selectedRowIndexPath = tableView.indexPathForSelectedRow {
                siteViewController.WebSiteView = savedSplitWebView
                siteViewController.loadThisSite = WebSiteList![selectedRowIndexPath.row]
                //siteViewController.WebSiteView.alpha = 1.0
                
            
                
            }
        }
    }


}