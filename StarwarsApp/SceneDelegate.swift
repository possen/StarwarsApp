//
//  SceneDelegate.swift
//  StarwarsApp
//
//  Created by Paul Ossenbruggen on 6/2/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate, UISplitViewControllerDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let window = window else {
            return
        }
        guard let splitViewController = window.rootViewController as? UISplitViewController else {
            return
        }
        guard let navigationController = splitViewController.viewControllers.last as? UINavigationController else {
            return
        }
        let navItem = navigationController.topViewController?.navigationItem
        navItem?.leftBarButtonItem = splitViewController.displayModeButtonItem
        navItem?.leftItemsSupplementBackButton = true
        splitViewController.delegate = self
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }

    // MARK: - Split view

    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController:UIViewController,
        onto primaryViewController:UIViewController
    ) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else {
            return false
        }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController else {
            return false
        }
        if topAsDetailController.detailItem == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        return false
    }

}

