//
//  AppDelegate.swift
//  RevolutTest
//
//  Created by Egor Petrov on 05/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import UIKit
import SwiftyBeaver

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    enableLog()

    window = UIWindow(frame: UIScreen.main.bounds)
    window?.backgroundColor = .white
    let appRouter = AppRouter(window: window)
    let coordinator = FundsCoordinatorImpl(router: appRouter)
    coordinator.start()
    window?.makeKeyAndVisible()
    return true
  }

  func enableLog() {
    let console = ConsoleDestination()
    console.minLevel = .verbose
    log.addDestination(console)
  }
}
