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
    
    var missions: [Mission] = Mission.all()
    var isEditing: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func addMissionButtonPressed(sender: UIBarButtonItem) {
        isEditing = false
        performSegueWithIdentifier("DetailsSegue", sender: nil)
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailsSegue" {
                // set the same cdelegates
                let navigationController = segue.destinationViewController as! UINavigationController
                let controller = navigationController.topViewController as! MissionDetailsViewController
                controller.cancelButtonDelegate = self
                controller.delegate = self
               // if there is a cell as UITable View cell, set to indexPath
            // then give the controller missionToEdit the mission that was clicked (the sender)
            if isEditing! == true {
                if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                    controller.missionToEdit = missions[indexPath.row]
                }
            }
        }
    }
    
    func missionDetailsViewController(controller: MissionDetailsViewController, didFinishAddingMission mission: String) {
        dismissViewControllerAnimated(true, completion: nil)
        
        let missionToSave = Mission(obj: mission)
        missionToSave.save()
        
        tableView.reloadData()
        
    }
    
    func missionDetailsViewController(controller: MissionDetailsViewController, didFinishEditingMission mission: Mission) {
        
    
        
        dismissViewControllerAnimated(true, completion: nil)
        mission.save()
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        missions[indexPath.row].delete()
        missions.removeAtIndex(indexPath.row)
        tableView.reloadData()
    }
    
    // when the accessory button is tapped we are going to trigger this function to performe the segue with the EditMission segue,
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        isEditing = true
        performSegueWithIdentifier("DetailsSegue", sender: tableView.cellForRowAtIndexPath(indexPath))
        //  the sender for the segue is the particular cell whose accessory button was tapped.
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
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        print("Section: \(indexPath.section) and Row: \(indexPath.row)")
//        
//        print(missions[indexPath.row])
//        
//        print(missions[indexPath.row].createdAt)
//        
//        var mission = Mission(obj: missions[indexPath.row].mission)
//        mission.delete()
//        tableView.reloadData()
//    }


}

// steps for adding edit:
// 1. add the connection between bucket list contrller and mission details view controler
// 2. Give the connect an identifier
// 3. Add a variable var issionToEdit as an optional : Mission? in the Mission Details View Controller
// 4. Trigger a method that should run when the accessory button is pressed (in the bucket list view controller
// 4A. Performe the segue with the sender of the tableView.cellForRowAtIndexPath(indexPath) which is the cell whose index button was tapped
// 5. then modify prepare for segue in case sopmeone clicks the edit button since currently it only works if they click the add button
//6. Modify our missionsDetailsViewController delegate by adding a didFinishEditingMission function
//7. Implement out editingMission Protocol
//8. Go to missionDetailsViewController and check to see if we have var missionToEdit and then run the appropriate delegate button if we do (when doneButtonPressed happens
//9. back to bucket list, and on our didFinishEditing we can dismissAnimatedController which will basically take us back to Bucket List, then lets save and reload data.
//10. to do this we need to remove the string type from the delegate. Instead of passing mission.mission just pass the entire mission object.
