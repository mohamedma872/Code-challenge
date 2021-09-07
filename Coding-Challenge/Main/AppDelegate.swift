//
//  AppDelegate.swift
//  Coding-Challenge
//
//  Created by Mohamed Elsdody on 04/09/2021.
//

import UIKit
import Swinject
@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {
    var appCoordinator: AppCoordinator?
    internal let container = Container()
    var window: UIWindow?
    func application(_: UIApplication, willFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        setupDependencies()
        return true
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        startApp()
        return true
    }

    func startApp() {
        let navController = UINavigationController()
        window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator = AppCoordinator(window: window, navigationController: navController,container: container)
            appCoordinator?.start()
        }
    
}
