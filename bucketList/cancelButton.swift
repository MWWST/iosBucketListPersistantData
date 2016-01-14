//
//  cancelButton.swift
//  bucketList
//
//  Created by Michael Weitzman on 1/13/16.
//  Copyright © 2016 World Source Tech. All rights reserved.
//

import UIKit
protocol CancelButtonDelegate: class {
    func cancelButtonPressedFrom(controller: UIViewController)
}
