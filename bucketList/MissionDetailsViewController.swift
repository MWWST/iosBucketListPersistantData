//
//  MissionDetailsViewController.swift
//  bucketList
//
//  Created by Michael Weitzman on 1/13/16.
//  Copyright © 2016 World Source Tech. All rights reserved.
//

import UIKit

class MissionDetailsViewController: UITableViewController, UITextFieldDelegate {
    
    
    weak var cancelButtonDelegate: CancelButtonDelegate?
    weak var delegate: MissionDetailsViewControllerDelegate?
   
    // the mission to edit if we go to mission details view controller after clicking edit
    var missionToEdit: Mission?
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        cancelButtonDelegate?.cancelButtonPressedFrom(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.newMissionTextField.delegate = self;
        
        
        newMissionTextField.text = missionToEdit?.mission
        
        
    }
    
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        
        if let mission = missionToEdit {
            mission.mission = newMissionTextField.text!
            delegate?.missionDetailsViewController(self, didFinishEditingMission: mission)
        } else {
            let missionToSave = Mission(obj: newMissionTextField.text!)
            delegate?.missionDetailsViewController(self, didFinishAddingMission: missionToSave.mission)
        }
    
    }
    
    @IBOutlet weak var newMissionTextField: UITextField!
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
   
    
}
