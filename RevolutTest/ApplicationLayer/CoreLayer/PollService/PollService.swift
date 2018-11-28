//
//  PollService.swift
//  RevolutTest
//
//  Created by Egor Petrov on 28/11/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

protocol PollService {

  associatedtype Value: Decodable

  var onValueUpdate: (Value) -> Void { get set }

  func startPollingWith(parameter: String)

  func stopPolling()

  func updateRequstParameter(with newParameter: String)
}
