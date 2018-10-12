//
//  CellTitleView.swift
//  RevolutTest
//
//  Created by Egor Petrov on 11/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import UIKit

class CellTitleView: UIView {

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
    label.numberOfLines = 0
    return label
  }()

  private let subTitle: UILabel = {
    let label = UILabel()
    label.textColor = .gray
    label.font = UIFont.systemFont(ofSize: 14, weight: .light)
    label.numberOfLines = 0
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    addSubview(titleLabel)
    addSubview(subTitle)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
