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
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        cancelButtonDelegate?.cancelButtonPressedFrom(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.newMissionTextField.delegate = self;
    }
    
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        
       delegate?.missionDetailsViewController(self, didFinishAddingMission: newMissionTextField.text!)
        
        print(newMissionTextField.text!)

    }
    
    @IBOutlet weak var newMissionTextField: UITextField!
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
   
    
}
