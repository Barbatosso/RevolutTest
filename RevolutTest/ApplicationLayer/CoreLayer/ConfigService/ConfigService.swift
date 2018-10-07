//
//  ConfigService.swift
//  RevolutTest
//
//  Created by Egor Petrov on 07/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

class ConfigService: Configurator {

  lazy var apiUrl: URL = {
    guard let apiUrlString = currentConfig["api-Url"] as? String,
      let apiUrl = URL(string: apiUrlString) else {
        fatalError("No API URL found or its incorrect")
    }
    return apiUrl
  }()

  private lazy var currentConfig: [String: Any] = {
    let path = Bundle.main.path(forResource: "Config", ofType: "plist")!
    guard let config = NSDictionary(contentsOfFile: path) as? [String: Any] else {
      fatalError("No Config.plist file found.")
    }
    return config
  }()
}
