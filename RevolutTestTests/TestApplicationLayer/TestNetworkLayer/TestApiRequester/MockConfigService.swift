//
//  MockConfigService.swift
//  RevolutTestTests
//
//  Created by Egor Petrov on 10/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

struct MockConfigService: Configurator {

  var apiUrl: URL {
    guard let url = URL(string: "https://revolut.duckdns.org") else {
      fatalError("URL doesn't specified")
    }
    return url
  }

  var pollServiceDebounce: Double {
    return 1.0
  }
}
