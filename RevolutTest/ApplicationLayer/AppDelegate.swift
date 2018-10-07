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
    let console = ConsoleDestination()
    console.minLevel = .verbose
    log.addDestination(console)
    let mapper = JsonObjectMapper()
    let configService = ConfigService()
    let apiService = ApiService<Funds>(configService: configService, mapper: mapper)
    let fundsService = FundsServiceImpl(apiService: apiService)
    fundsService.fetchFunds(for: "CZK") { funds, _ in
      print(funds)
    }
    return true
  }
}
