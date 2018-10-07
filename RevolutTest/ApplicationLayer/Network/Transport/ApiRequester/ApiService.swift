//
//  ApiService.swift
//  RevolutTest
//
//  Created by Egor Petrov on 07/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

struct ApiService<Result: Decodable>: ApiRequester {

  private let configService: ConfigService
  private let mapper: Mapper

  init(configService: ConfigService, mapper: Mapper) {
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

  func runRequest(for target: ApiTarget,
                  with completionHandler: @escaping (Result?, Error?) -> Void) {
    var request = URLRequest(url: configService.apiUrl)
    request.url?.appendPathComponent(target.path)
    request.httpMethod = target.method.rawValue
    if let parameters = target.getParameters {
      request.convertToQueryString(parameters: parameters)
    }

    log.verbose(request.debugDescription)
    queue.async {
      self.urlSession.dataTask(with: request) { data, _, error in
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
          completionHandler(object, nil)
        } catch {
          log.error(error.localizedDescription)
          completionHandler(nil, error)
        }
      }
    }
  }
}
