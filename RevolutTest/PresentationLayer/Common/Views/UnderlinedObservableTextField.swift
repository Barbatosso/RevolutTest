//
//  UnderlinedObservableTextField.swift
//  RevolutTest
//
//  Created by Egor Petrov on 12/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import UIKit

class UnderlinedObservableTextField: ObservableTextField {

  private let lineView: UIView = {
    let view = UIView()
    view.isUserInteractionEnabled = false
    view.backgroundColor = .lightGray
    return view
  }()

  override init() {
    super.init()

    addSubview(lineView)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    setupLayoutFor(lineView)
  }

  private func setupLayoutFor(_ line: UIView) {
    line.frame = CGRect(x: 0, y: bounds.height - line.frame.height,
                        width: bounds.width, height: 0.5)
  }
}
