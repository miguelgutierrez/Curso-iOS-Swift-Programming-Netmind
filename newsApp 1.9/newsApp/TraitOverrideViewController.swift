//
//  TraitOverrideViewController.swift
//  newsApp
//
//  Created by Miguel Gutiérrez Moreno on 4/2/15.
//  Copyright (c) 2015 MGM. All rights reserved.
//

import UIKit


class TraitOverrideViewController: UIViewController, UISplitViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performTraitCollectionOverrideForSize(view.bounds.size)
        configureSplitVC()
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        performTraitCollectionOverrideForSize(size)
    }
    
    private func performTraitCollectionOverrideForSize(size: CGSize) {

        var overrideTraitCollection: UITraitCollection? = nil
        if size.width > 375 { //  if size.width > 320 {
            overrideTraitCollection = UITraitCollection(horizontalSizeClass: .Regular)
        }
        for vc in self.childViewControllers as [UIViewController] {
            setOverrideTraitCollection(overrideTraitCollection, forChildViewController: vc)
        }

    }
    
    private func configureSplitVC() {
        // Set up split view delegate
        let splitVC = self.childViewControllers[0] as UISplitViewController
        splitVC.delegate = self

        // splitVC.preferredPrimaryColumnWidthFraction = 0.3
        let navVC = splitVC.childViewControllers.last as UINavigationController
        navVC.topViewController.navigationItem.leftBarButtonItem = splitVC.displayModeButtonItem()

    }
    
    
    // MARK: - Split view
    
    func splitViewController(splitViewController: UISplitViewController!, collapseSecondaryViewController secondaryViewController:UIViewController!, ontoPrimaryViewController primaryViewController:UIViewController!) -> Bool {
        if let secondaryAsNavController = secondaryViewController as? UINavigationController {
            if let topAsDetailController = secondaryAsNavController.topViewController as? DetalleArticuloViewController {
                if topAsDetailController.articulo == nil {
                    // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
                    return true
                }
            }
        }
        return false
    }
}
