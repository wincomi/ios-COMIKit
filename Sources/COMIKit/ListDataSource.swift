import UIKit

class ListDataSource<Section: SectionRepresentable & Hashable>: UITableViewDiffableDataSource<Section, Section.Row> where Section.Row: Hashable {
	typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Section.Row>

	// MARK: Headers, and Footers
	var titleForHeader: ((_ tableView: UITableView, _ section: Int) -> String?)?
	var titleForFooter: ((_ tableView: UITableView, _ section: Int) -> String?)?

	// MARK: Inserting or Deleting Table Rows
	var commit: ((_ tableView: UITableView, _ editingStyle: UITableViewCell.EditingStyle, _ indexPath: IndexPath) -> Void)?
	var canEdit: ((_ tableView: UITableView, _ indexPath: IndexPath) -> Bool)?

	// MARK: Reordering Table Rows
	var canMove: ((_ tableView: UITableView, _ indexPath: IndexPath) -> Bool)?
	var move: ((_ tableView: UITableView, _ sourceIndexPath: IndexPath, _ destinationIndexPath: IndexPath) -> Void)?

	// MARK: Configuring an Index
	var sectionIndexTitles: ((_ tableView: UITableView) -> [String]?)?
	var sectionForSectionIndexTitle: ((_ tableView: UITableView, _ title: String, _ section: Int) -> Int)?

	// MARK: Functions
	func clear(animatingDifferences: Bool = false) {
		apply(Snapshot(), animatingDifferences: animatingDifferences)
	}

	func apply(with sections: [Section], animatingDifferences: Bool, completion: (() -> Void)? = nil) {
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

	// MARK: UITableViewDataSource
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		guard let titleForHeader = titleForHeader else { return snapshot().sectionIdentifiers[section].headerText }
		return titleForHeader(tableView, section)
	}

	override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
		guard let titleForFooter = titleForFooter else { return snapshot().sectionIdentifiers[section].footerText }
		return titleForFooter(tableView, section)
	}

	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		commit?(tableView, editingStyle, indexPath)
	}

	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return canEdit?(tableView, indexPath) ?? false
	}

	override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
		return canMove?(tableView, indexPath) ?? false
	}

	override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
		move?(tableView, sourceIndexPath, destinationIndexPath)
	}

	override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
		return sectionIndexTitles?(tableView)
	}

	override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
		return sectionForSectionIndexTitle?(tableView, title, index) ?? index
	}

}
