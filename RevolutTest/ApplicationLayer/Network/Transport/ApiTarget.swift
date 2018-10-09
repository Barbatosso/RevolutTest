//
//  ApiTarget.swift
//  RevolutTest
//
//  Created by Egor Petrov on 06/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

protocol ApiTarget {

  var method: HTTPMethod { get }
  var path: String { get }
  var parameters: [String: Any]? { get }
}
