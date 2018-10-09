//
//  URLRequest+Encoding.swift
//  RevolutTest
//
//  Created by Egor Petrov on 07/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

extension URLRequest {

  mutating func addQury(parameters: [String: Any]?) {
    guard var urlString = url?.absoluteString,
          let parameters = parameters else { return }
    urlString += parameters.map { "\($0)=\($1)"}.joined(separator: "&")
    url = URL(string: urlString)
  }
}
