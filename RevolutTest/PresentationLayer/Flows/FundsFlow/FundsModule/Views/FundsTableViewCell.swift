//
//  FundsTableViewCell.swift
//  RevolutTest
//
//  Created by Egor Petrov on 11/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import UIKit

class FundsTableViewCell: UITableViewCell {

  private let flagImageView: UIImageView = {
    let imageView = RoundImageView()
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
}
