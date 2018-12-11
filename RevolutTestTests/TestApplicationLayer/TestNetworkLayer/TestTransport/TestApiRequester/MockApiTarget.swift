//
//  MockApiTarget.swift
//  RevolutTestTests
//
//  Created by Egor Petrov on 10/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

enum MockApiTarget: ApiTarget {

  case getMockData

  var method: HTTPMethod {
    return .get
  }

  var path: String {
    return "latest"
  }

  var parameters: [String: Any]? {
    return nil
  }
}
