//
//  EmptyDataViewPresentable.swift
//  COMIKit
//

import UIKit
import SwiftUI

public protocol EmptyDataViewPresentable {
	func install(emptyDataView: EmptyDataView)
	func removeEmptyDataView()
}

extension EmptyDataViewPresentable where Self: UITableViewController {
	public func install(emptyDataView: EmptyDataView) {
		let vc = UIHostingController(rootView: emptyDataView)
		tableView.backgroundView = vc.view
		tableView.separatorStyle = .none
	}

	public func removeEmptyDataView() {
		removeEmptyDataView(tableViewBackgroundView: nil, tableViewSeparatorStyle: .singleLine)
	}

	public func removeEmptyDataView(tableViewBackgroundView: UIView? = nil, tableViewSeparatorStyle: UITableViewCell.SeparatorStyle = .singleLine) {
		tableView.backgroundView = tableViewBackgroundView
		tableView.separatorStyle = tableViewSeparatorStyle
	}
}
