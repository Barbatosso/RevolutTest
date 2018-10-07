//
//  JsonObjectMapper.swift
//  RevolutTest
//
//  Created by Egor Petrov on 07/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

struct JsonObjectMapper: Mapper {

  private let decoder: JSONDecoder = {
    let decoder = JSONDecoder()
    return decoder
  }()

  func result<Result: Decodable>(from json: Data) throws -> Result? {
    do {
      return try decoder.decode(Result.self, from: json)
    } catch {
      log.error(error)
      throw ApiError.badServerResponse
    }
  }
}
