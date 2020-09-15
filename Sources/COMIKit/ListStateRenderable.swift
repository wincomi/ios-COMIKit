import UIKit

public protocol ListStateRenderable {
	associatedtype Section: SectionRepresentable & Hashable where Section.Row: Hashable
	associatedtype Failure: Error
	typealias State = ListState<Section, Failure>

	func render(_ state: State, animated: Bool)
}

extension ListStateRenderable where Self: ListDataSourceRenderable {
	public func render(_ sections: [Section], animated: Bool = false) {
		dataSource.apply(with: sections, animatingDifferences: animated)
	}
}
