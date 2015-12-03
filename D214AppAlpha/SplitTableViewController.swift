//
//  SelectColorTableViewController.swift
//  SplitViewControllerDemo
//
//  Created by Natasha Murashev on 10/27/14.
//  Copyright (c) 2014 NatashaTheRobot. All rights reserved.
//

import UIKit

struct Cinfo {
    let cells: SuString
}

class SelectColorTableViewController: UITableViewController {

    private let colorCellIdentifier = "colorCell"
    
    var collapseDetailViewController: Bool  = true
    
    private let cinfo = [
        Cinfo(cells: SuString(title: "Google", url: NSURL(string: "http://www.google.com")!, info: "Google")),
        Cinfo(cells: SuString(title: "NShipster", url: NSURL(string: "http://nshipster.com/uisplitviewcontroller/")!, info: "JHHS")),
    ]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // identifier if required, if you have more then one segue
        // it could be set via IB, i did ...
        if segue.identifier == "show_detail_segue_id" {
            
            // colorViewController should never be assigned to nil !!!
            var colorViewController: ColorViewController!
            
            // with help of adaptive segue we can support all devices
            if let colorNavigationController = segue.destinationViewController as? UINavigationController {

                // works on devices where UISplitViewController is implemented
                colorViewController = colorNavigationController.topViewController as! ColorViewController
                colorViewController.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                colorViewController.navigationItem.leftItemsSupplementBackButton = true
            } else {

                // works for iPhone on ios7, where UISplitViewController is not implemented
                colorViewController = segue.destinationViewController as! ColorViewController
            }
            // this is common part, where one can configure detail view
            // segue provides a new instance of detail view everytime
            if let selectedRowIndexPath = tableView.indexPathForSelectedRow() {
                let dud = cinfo[selectedRowIndexPath.row]
                colorViewController.bob = dud
                

            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cinfo.count
    }
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(colorCellIdentifier) as! UITableViewCell
        
        let color = cinfo[indexPath.row]
        cell.textLabel?.text = color.cells.getName()
        cell.detailTextLabel?.text = color.cells.getInfo()
        
        
        
        
        return cell
    }
    
    // MARK: Table View Delegate

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        collapseDetailViewController = false
    }

}
