//
//  ViewController.swift
//  bucketList
//
//  Created by Michael Weitzman on 1/13/16.
//  Copyright © 2016 World Source Tech. All rights reserved.
//

import UIKit

class BucketListViewController: UITableViewController, CancelButtonDelegate, MissionDetailsViewControllerDelegate {
    
    

    func cancelButtonPressedFrom(controller: UIViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
     var missions = Mission.all()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddNewMission" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! MissionDetailsViewController
            controller.cancelButtonDelegate = self
             controller.delegate = self
        }
    }
    
    func missionDetailsViewController(controller: MissionDetailsViewController, didFinishAddingMission mission: String) {
        dismissViewControllerAnimated(true, completion: nil)

        var mission = Mission(obj: mission)
        mission.save()
        
        tableView.reloadData()
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // dequeue the cell from our storyboard
        let cell = tableView.dequeueReusableCellWithIdentifier("MissionCell")!
        // if the cell has a text label, set it to the model that is corresponding to the row in array
        cell.textLabel?.text = missions[indexPath.row].mission
        // return cell so that Table View knows what to draw in each row
        return cell
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        missions = Mission.all()
        return Mission.all().count
    }
    
    // why override? also wtf are they talking about returing an array of objects instead of strings.
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Section: \(indexPath.section) and Row: \(indexPath.row)")
        
        print(missions[indexPath.row])
        
        print(missions[indexPath.row].createdAt)
        
        var mission = Mission(obj: missions[indexPath.row].mission)
        mission.delete()
        tableView.reloadData()
    }


}

