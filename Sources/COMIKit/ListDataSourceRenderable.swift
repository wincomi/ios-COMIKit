import UIKit

protocol ListDataSourceRenderable {
	associatedtype Section: SectionRepresentable & Hashable where Section.Row: Hashable
	typealias DataSource = ListDataSource<Section>

	var dataSource: DataSource { get set }
	func setupListDataSource()
}

extension ListDataSourceRenderable where Self: UITableViewController {
	func setupListDataSource() {
		tableView.dataSource = dataSource
	}
}
