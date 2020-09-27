//
//  ListDataSource.swift
//  COMIKit
//

import UIKit

open class ListDataSource<Section: SectionRepresentable & Hashable>: UITableViewDiffableDataSource<Section, Section.Row> where Section.Row: Hashable {
	typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Section.Row>

	// MARK: - CellProviders
	public enum CellProviders {
		public static func `default`() -> ListDataSource<Section>.CellProvider {
			return { (tableView, indexPath, row) in
				guard let cell = tableView.dequeueReusableCell(withIdentifier: ValueTableViewCell.reuseIdentifier, for: indexPath) as? ValueTableViewCell else { return nil }
				cell.configure(with: row)
				return cell
			}
		}

		public static func subtitle() -> ListDataSource<Section>.CellProvider {
			return { (tableView, indexPath, row) in
				guard let cell = tableView.dequeueReusableCell(withIdentifier: SubtitleTableViewCell.reuseIdentifier, for: indexPath) as? SubtitleTableViewCell else { return nil }
				cell.configure(with: row)
				return cell
			}
		}
	}

	// MARK: - Headers, and Footers
	public var titleForHeader: ((_ tableView: UITableView, _ section: Int) -> String?)?
	public var titleForFooter: ((_ tableView: UITableView, _ section: Int) -> String?)?

	// MARK: - Inserting or Deleting Table Rows
	public var commit: ((_ tableView: UITableView, _ editingStyle: UITableViewCell.EditingStyle, _ indexPath: IndexPath) -> Void)?
	public var canEdit: ((_ tableView: UITableView, _ indexPath: IndexPath) -> Bool)?

	// MARK: - Reordering Table Rows
	public var canMove: ((_ tableView: UITableView, _ indexPath: IndexPath) -> Bool)?
	public var move: ((_ tableView: UITableView, _ sourceIndexPath: IndexPath, _ destinationIndexPath: IndexPath) -> Void)?

	// MARK: - Configuring an Index
	public var sectionIndexTitles: ((_ tableView: UITableView) -> [String]?)?
	public var sectionForSectionIndexTitle: ((_ tableView: UITableView, _ title: String, _ section: Int) -> Int)?

	// MARK: - Updating Data
	public func clear(animatingDifferences: Bool = false) {
		apply(Snapshot(), animatingDifferences: animatingDifferences)
	}

	public func apply(with sections: [Section], animatingDifferences: Bool, completion: (() -> Void)? = nil) {
		apply(snapshot(for: sections), animatingDifferences: animatingDifferences)
	}

	private func snapshot(for sections: [Section]) -> Snapshot {
		var snapshot = Snapshot()

		snapshot.appendSections(sections)
		sections.forEach { section in
			snapshot.appendItems(section.rows, toSection: section)
		}

		return snapshot
	}

	// MARK: - UITableViewDataSource
	public override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		guard let titleForHeader = titleForHeader else { return snapshot().sectionIdentifiers[section].headerText }
		return titleForHeader(tableView, section)
	}

	public override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
		guard let titleForFooter = titleForFooter else { return snapshot().sectionIdentifiers[section].footerText }
		return titleForFooter(tableView, section)
	}

	public override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		commit?(tableView, editingStyle, indexPath)
	}

	public override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return canEdit?(tableView, indexPath) ?? false
	}

	public override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
		return canMove?(tableView, indexPath) ?? false
	}

	public override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
		move?(tableView, sourceIndexPath, destinationIndexPath)
	}

	public override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
		return sectionIndexTitles?(tableView)
	}

	public override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
		return sectionForSectionIndexTitle?(tableView, title, index) ?? index
	}
}
