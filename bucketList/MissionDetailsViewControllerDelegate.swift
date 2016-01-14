//
//  saveProtocol.swift
//  bucketList
//
//  Created by Michael Weitzman on 1/13/16.
//  Copyright © 2016 World Source Tech. All rights reserved.
//

import Foundation
protocol MissionDetailsViewControllerDelegate: class {
    func missionDetailsViewController(controller: MissionDetailsViewController, didFinishAddingMission mission: String)
}