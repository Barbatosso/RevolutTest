//
//  URLRequest+Encoding.swift
//  RevolutTest
//
//  Created by Egor Petrov on 07/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

extension URLRequest {

  mutating func addQuery(parameters: [String: Any]?) {
    guard var urlString = url?.absoluteString,
          let parameters = parameters else { return }
    urlString += parameters.map { "\($0)=\($1)"}.joined(separator: "&")
    url = URL(string: urlString)
  }

  mutating func resolvePercentEncodedUrl() {
    guard let url = url else { return }
    var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
    let percentEncodedQuery = urlComponents?.percentEncodedQuery.map { $0 + "&" } ?? ""
    urlComponents?.percentEncodedQuery = percentEncodedQuery
    self.url = urlComponents?.url
  }
}
