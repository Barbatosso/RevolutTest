//
//  FundsServiceTarget.swift
//  RevolutTest
//
//  Created by Egor Petrov on 07/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

enum FundsServiceTarget: ApiTarget {

  case funds(base: String)

  var method: HTTPMethod {
    return .get
  }

  var path: String {
    return "latest"
  }

  var parameters: [String: Any]? {
    switch self {
    case .funds(let base):
      return ["base": base]
    }
  }

  var postParameters: Encodable? {
    return nil
  }
}
