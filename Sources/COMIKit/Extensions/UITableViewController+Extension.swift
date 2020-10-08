//
//  UITableViewController+Extension.swift
//  COMIKit
//

import UIKit

public extension UITableViewController {
	var isSelectedAnyRowInTableView: Bool {
		(tableView.indexPathsForSelectedRows?.count ?? 0) > 0
	}

	func deselectAllRowsInTableView() {
		for section in 0..<tableView.numberOfSections {
			for row in 0..<tableView.numberOfRows(inSection: section) {
				let indexPath = IndexPath(row: row, section: section)
				tableView.deselectRow(at: indexPath, animated: true)
				tableView(tableView, didDeselectRowAt: indexPath)
			}
		}
	}

	func selectAllRowsInTableView() {
		for section in 0..<tableView.numberOfSections {
			for row in 0..<tableView.numberOfRows(inSection: section) {
				let indexPath = IndexPath(row: row, section: section)
				tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
				tableView(tableView, didSelectRowAt: indexPath)
			}
		}
	}
}

public extension ListDataSourceRenderable where Self: UITableViewController {
	var isSelectedAllRowsInTableView: Bool {
		(tableView.indexPathsForSelectedRows?.count ?? 0) == dataSource.snapshot().itemIdentifiers.count
	}

	var selectedRowsInTableView: [Section.Row] {
		tableView.indexPathsForSelectedRows?.map { indexPath -> Section.Row in
			let section = dataSource.snapshot().sectionIdentifiers[indexPath.section]
			return dataSource.snapshot().itemIdentifiers(inSection: section)[indexPath.row]
		} ?? []
	}
}
