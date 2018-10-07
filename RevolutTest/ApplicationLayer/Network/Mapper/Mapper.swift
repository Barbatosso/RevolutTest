//
//  Mapper.swift
//  RevolutTest
//
//  Created by Egor Petrov on 07/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

protocol Mapper {

  func result<Result: Decodable>(from json: Data) throws -> Result?
}
