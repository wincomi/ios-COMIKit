//
//  ValueTableViewCell.swift
//  COMIKit
//

import UIKit

open class ValueTableViewCell: UITableViewCell {
	public static let reuseIdentifier = "ValueTableViewCell"

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .value1, reuseIdentifier: reuseIdentifier)
	}

	required public init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	open override func layoutSubviews() {
		super.layoutSubviews()

		detailTextLabel?.textColor = .secondaryLabel
	}

	open func configure(with row: RowRepresentable) {
		textLabel?.text = row.text
		detailTextLabel?.text = row.secondaryText
		imageView?.image = row.image
	}
}
