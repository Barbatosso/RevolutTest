//
//  Configurator.swift
//  RevolutTest
//
//  Created by Egor Petrov on 07/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

protocol Configurator {

  var apiUrl: URL { get }
  var pollServiceDelay: Double { get }
}
