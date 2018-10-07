//
//  ApiService.swift
//  RevolutTest
//
//  Created by Egor Petrov on 07/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

class ApiService: ApiRequester {

  internal let queue: DispatchQueue = {
    let queue = DispatchQueue(label: "standart_api_service_queue", qos: .default, attributes: .concurrent)
    return queue
  }()

  internal let urlSession: URLSession = {
    let urlSession = URLSession.shared
    return urlSession
  }()

  func runRequest<Object: Decodable>(for target: ApiTarget,
                                     with completionHandler: @escaping (Object?, Error?) -> Void) {

  }
}
