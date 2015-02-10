//
//  TabBarController(rotate).swift
//  funnyApp
//
//  Created by Miguel Gutiérrez Moreno on 22/1/15.
//  Copyright (c) 2015 MGM. All rights reserved.
//

import UIKit

extension UITabBarController {

    public override func shouldAutorotate() -> Bool {
        if let selectedViewController = self.selectedViewController {
            return selectedViewController.shouldAutorotate()
        }
        return true
//        return false
    }
}
