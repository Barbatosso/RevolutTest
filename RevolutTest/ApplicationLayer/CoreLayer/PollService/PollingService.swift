//
//  PollingService.swift
//  RevolutTest
//
//  Created by Egor Petrov on 28/11/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

protocol PollingService {

  associatedtype Result: Decodable

  typealias UpdateValueHandler = (Result?, Error?) -> Void

  var onValueUpdate: UpdateValueHandler? { get set }

  func startPollingWith(parameter: String) throws

  func stopPolling()

  func updateRequstParameter(with newParameter: String)
}
