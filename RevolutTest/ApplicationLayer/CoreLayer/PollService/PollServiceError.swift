//
//  PollServiceError.swift
//  RevolutTest
//
//  Created by Egor Petrov on 01/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

enum PollServiceError: LocalizedError {

  case timerIsNotConfigured

  var errorDescription: String? {
    switch self {
    case .timerIsNotConfigured:
      return "poll_service_error_timer_is_not_configured"
    }
  }
}
