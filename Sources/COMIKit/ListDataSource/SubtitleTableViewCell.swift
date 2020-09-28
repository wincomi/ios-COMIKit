//
//  SubtitleTableViewCell.swift
//  COMIKit
//

import UIKit

open class SubtitleTableViewCell: UITableViewCell {
	public static let reuseIdentifier = "SubtitleTableViewCell"

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
	}

	required public init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	open func configure(with row: RowRepresentable) {
		textLabel?.text = row.text
		detailTextLabel?.text = row.secondaryText
		imageView?.image = row.image
	}
}
