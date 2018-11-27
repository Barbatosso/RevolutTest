//
//  RoundImageView.swift
//  RevolutTest
//
//  Created by Egor Petrov on 11/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import UIKit

class RoundImageView: UIImageView {

  override func layoutSubviews() {
    super.layoutSubviews()

    makeRoundCorners()
  }

  private func makeRoundCorners() {
    if #available(iOS 11.0, *) {
      layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
      layer.cornerRadius = bounds.width
    } else {
      let roundMaskLayer = CAShapeLayer()
      roundMaskLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.width * 0.5).cgPath
      layer.mask = roundMaskLayer
    }
  }
}
