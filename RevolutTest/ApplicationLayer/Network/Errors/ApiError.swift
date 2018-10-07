//
//  ApiError.swift
//  RevolutTest
//
//  Created by Egor Petrov on 07/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

enum ApiError: LocalizedError {

  case badServerResponse

  var localizedDescription: String {
    switch self {
    case .badServerResponse:
      return "bad_server_response_error".localized
    }
  }
}
