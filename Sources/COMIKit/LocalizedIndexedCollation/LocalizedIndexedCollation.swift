//
//  LocalizedIndexedCollation.swift
//  COMIKit
//

import UIKit

open class LocalizedIndexedCollation<Value> {
	private class Item {
		var value: Value
		@objc var collationString: String

		init(_ value: Value, keyPath: KeyPath<Value, String>) {
			self.value = value
			self.collationString = value[keyPath: keyPath]
		}
	}

	public struct Section: Hashable {
		public var title: String
		public var items: [Value]

		public static func == (lhs: Self, rhs: Self) -> Bool {
			lhs.title == rhs.title
		}

		public func hash(into hasher: inout Hasher) {
			hasher.combine(title)
		}
	}

	public var sections: [Section]

	public init(items: [Value], sortBy keyPath: KeyPath<Value, String>) {
		let collation = UILocalizedIndexedCollation.current()

		let selector = #selector(getter: Item.collationString)

		let collationItems = items.map { Item($0, keyPath: keyPath) }
		guard let sortedItems = collation.sortedArray(from: collationItems, collationStringSelector: selector) as? [Item] else { fatalError() }

		self.sections = {
			var sections = collation.sectionTitles.map {
				Section(title: $0, items: [])
			}
			sortedItems.forEach {
				let sectionNumber = collation.section(for: $0, collationStringSelector: selector)
				sections[sectionNumber].items.append($0.value)
			}
			return sections.filter { !$0.items.isEmpty }
		}()
	}
}

// MARK: - SectionRepresentable
extension LocalizedIndexedCollation.Section: SectionRepresentable where Value: RowRepresentable {
	public var headerText: String? { title }
	public var footerText: String? { nil }
	public var rows: [Value] { items }
}

// MARK: - Identifiable
extension LocalizedIndexedCollation.Section: Identifiable {
	public var id: String { title }
}
