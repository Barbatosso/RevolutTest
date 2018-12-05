//
//  FundsTableViewCell.swift
//  RevolutTest
//
//  Created by Egor Petrov on 11/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import UIKit
import SnapKit

class FundsTableViewCell: UITableViewCell, ConfigurableCell {

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
    let textField = UnderlinedObservableTextField()
    textField.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
    textField.textColor = .black
    textField.textAlignment = .right
    textField.isEnabled = false
    textField.keyboardType = .numberPad
    return textField
  }()

  override func becomeFirstResponder() -> Bool {
    super.becomeFirstResponder()

    fundsTextField.isEnabled = true
    fundsTextField.becomeFirstResponder()
    return true
  }

  override func resignFirstResponder() -> Bool {
    super.resignFirstResponder()

    fundsTextField.isEnabled = false
    fundsTextField.resignFirstResponder()
    return true
  }

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
      make.leading.greaterThanOrEqualTo(fundTitleLabel.snp.trailing)
      make.trailing.equalTo(snp.trailingMargin)
    }
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setNewFund(_ value: Double) {
    fundsTextField.text = string(for: value)
  }

  func configure(with data: FundsItem) {
    flagImageView.image = UIImage(named: data.fundsCode)
    fundTitleLabel.text = data.fundsCode
    fundsTextField.text = string(for: data.value)
  }

  private func string(for value: Double) -> String {
    return String(format: "%.3f", value)
  }

  override func prepareForReuse() {
    super.prepareForReuse()

    fundsTextField.text = nil
    fundTitleLabel.text = nil
  }
}
