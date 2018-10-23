//
//  FundsTableViewCell.swift
//  RevolutTest
//
//  Created by Egor Petrov on 11/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import UIKit
import SnapKit

class FundsTableViewCell: UITableViewCell {

  private let imageSizeDimension = 60

  private let flagImageView: UIImageView = {
    let imageView = RoundImageView()
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  private let fundCodeLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    label.textColor = .black
    label.textAlignment = .left
    return label
  }()

  private let fundTitleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14, weight: .light)
    label.textColor = .gray
    label.textAlignment = .left
    return label
  }()

  let fundsTextField: UITextField = {
    let textField = UnderlinedTextField()
    textField.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
    textField.textColor = .black
    textField.textAlignment = .left
    return textField
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    contentView.addSubview(flagImageView)
    contentView.addSubview(fundCodeLabel)
    contentView.addSubview(fundTitleLabel)
    contentView.addSubview(fundsTextField)

    flagImageView.snp.makeConstraints { make in
      make.size.equalTo(imageSizeDimension)
      make.centerY.equalToSuperview()
      make.leading.equalTo(snp.leadingMargin)
    }

    fundCodeLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(10)
      make.leading.equalTo(flagImageView.snp.trailingMargin)
    }

    fundTitleLabel.snp.makeConstraints { make in
      make.top.equalTo(fundCodeLabel.snp.bottom).offset(10)
      make.leading.equalTo(flagImageView.snp.trailingMargin)
      make.bottom.equalToSuperview().inset(10)
    }

    fundsTextField.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.leading.equalTo(fundTitleLabel.snp.trailingMargin)
      make.trailing.equalTo(snp.trailingMargin)
    }
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configureInitialState(with fundCode: String, fundTitle: String, amount: Double) {
    flagImageView.image = UIImage(named: fundCode)
    fundCodeLabel.text = fundCode
    fundTitleLabel.text = fundTitle
    fundsTextField.text = String(amount)
    fundsTextField.isEnabled = false
  }

  func configureForEditing() {
    fundsTextField.isEnabled = true
  }

  func setNewFund(value: Double) {
    fundsTextField.text = String(value)
  }
}
