//
//  MainTableViewController.swift
//  D214AppAlpha
//
//  Created by mobileapps on 11/6/15.
//  Copyright © 2015 JohnHerseyHighSchool. All rights reserved.
//

import UIKit

class MainTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var DataBaseTable: UITableView!
    @IBOutlet weak var ResourceTable: UITableView!
    @IBOutlet weak var WritingTable: UITableView!
    
    @IBOutlet weak var MainSegmentedControl: UISegmentedControl!
    
    var savedWebView: UIWebView?
    var selectedData: SuString?
    
    var databases = [SuString]()
    var resorces = [SuString]()
    var writing = [SuString]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         MainSegmentedControl.selectedSegmentIndex = -1
        databases = getList("databases")
        resorces = getList("")
        writing = getList("")
    }
    
    @IBAction func segmentedControlChanged(sender: UISegmentedControl) {
        DataBaseTable.reloadData()
        ResourceTable.reloadData()
        WritingTable.reloadData()
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        let returnValue = 0
        switch(MainSegmentedControl.selectedSegmentIndex){
        case 0:
            return databases.count
            break
            
        case 1:
            return resorces.count
            break
            
        case 2:
            return writing.count
            break
            
        default:
            break
        }
        return returnValue
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell = UITableViewCell()
        switch(MainSegmentedControl.selectedSegmentIndex){
        case 0:
            cell = DataBaseTable.dequeueReusableCellWithIdentifier("CellDataBase", forIndexPath: indexPath) as! UITableViewCell
            cell.textLabel?.text = databases[indexPath.row].getName()
            setAlphas([1.0,0.0,0.0])
            break;
            
        case 1:
            cell = ResourceTable.dequeueReusableCellWithIdentifier("CellResource", forIndexPath: indexPath) as! UITableViewCell
            cell.textLabel?.text = resorces[indexPath.row].getName()
            setAlphas([0.0,1.0,0.0])
            break
            
        case 2:
            cell = WritingTable.dequeueReusableCellWithIdentifier("CellWriting", forIndexPath: indexPath) as! UITableViewCell
            cell.textLabel?.text = writing[indexPath.row].getName()
            setAlphas([0.0,0.0,1.0])
            break
        default:
            break
        }
        
        
        return cell
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCell = tableView.cellForRowAtIndexPath(indexPath)
        switch(MainSegmentedControl.selectedSegmentIndex){
        case 0:
            
            break
        case 1:
            selectedData = resorces[indexPath.row]
            performSegueWithIdentifier("SingleWebViewSegue", sender: selectedCell)
            break
        case 2:
            selectedData = writing[indexPath.row]
            performSegueWithIdentifier("SingleWebViewSegue", sender: selectedCell)
            break
        default:
            break
        }
    }
    
    
    
    func getList(names: [String], urls: [String], infos: [String]) -> [SuString]{
        
        var list = [SuString]()
        
        for i in 0...names.count-1{
            
            list.append(SuString(title: names[i], url: NSURL(string: urls[i])!, info: infos[i]))
            
        }
        return list
        
        
    }
    
    func getList(filename: String) -> [SuString]{
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
    func setAlphas(alphas: [CGFloat]){
        
        DataBaseTable.alpha = alphas[0]
        ResourceTable.alpha = alphas[1]
        WritingTable.alpha = alphas[2]
        
    }

   
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SingleWebViewSegue"
        {
            let nextPath: SingleWebView = segue.destinationViewController as! SingleWebView
            nextPath.SingleWebViewer = savedWebView
            nextPath.cellSelected = selectedData
            
        }
    }
    


    

    
}

