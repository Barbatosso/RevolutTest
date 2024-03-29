//
//  ApiService.swift
//  RevolutTest
//
//  Created by Egor Petrov on 07/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

struct ApiService: ApiRequester {

  private let configService: Configurator
  private let mapper: Mapper

  init(configService: Configurator, mapper: Mapper) {
    self.configService = configService
    self.mapper = mapper
  }

  internal let queue: DispatchQueue = {
    let queue = DispatchQueue(label: "standart_api_service_queue", qos: .default, attributes: .concurrent)
    return queue
  }()

  internal let urlSession: URLSession = {
    let urlSession = URLSession.shared
    return urlSession
  }()

  func runRequest<Result: Decodable>(for target: ApiTarget,
                                     with completionHandler: @escaping (Result?, Error?) -> Void) {
    var request = URLRequest(url: configService.apiUrl)
    request.url?.appendPathComponent(target.path)
    request.resolvePercentEncodedUrl()

    request.httpMethod = target.method.rawValue
    request.addQuery(parameters: target.parameters)

    log.verbose(request.debugDescription)
    queue.async {
      let task = self.urlSession.dataTask(with: request) { data, _, error in
        if let error = error {
          completionHandler(nil, error)
        }
        guard let data = data else {
          completionHandler(nil, ApiError.badServerResponse)
          return
        }

        log.verbose([request.description, String(data: data, encoding: .utf8)])

        do {
          let object: Result? = try self.mapper.result(from: data)
          DispatchQueue.main.async {
            completionHandler(object, nil)
          }
        } catch {
          log.error(error.localizedDescription)
          completionHandler(nil, error)
        }
      }
      task.resume()
    }
  }
}
