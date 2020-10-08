//
//  ToolbarItemsProvider.swift
//  COMIKit
//

import UIKit

public protocol ToolbarItemsProvider {
	typealias ToolbarItem = UIBarButtonItem
	associatedtype ToolbarItemType

	func toolbarItem(for type: ToolbarItemType) -> ToolbarItem?
	func toolbarItems(for types: [ToolbarItemType], withFlexibleSpace insertingFlexibleSpace: Bool) -> [ToolbarItem]
}

public extension ToolbarItemsProvider {
	func toolbarItems(for types: [ToolbarItemType], withFlexibleSpace insertingFlexibleSpace: Bool = false) -> [ToolbarItem] {
		var toolbarItems = types.compactMap(toolbarItem(for:))
		if insertingFlexibleSpace {
			toolbarItems = toolbarItems.reduce([]) { (result, toolbarItem) -> [UIBarButtonItem] in
				result + [toolbarItem, .flexibleSpace()]
			}
			toolbarItems.removeLast()
		}
		return toolbarItems
	}
}

public extension ToolbarItemsProvider where ToolbarItemType: CaseIterable {
	func toolbarItems(withFlexibleSpace insertingFlexibleSpace: Bool = false) -> [ToolbarItem] {
		return toolbarItems(for: Array(ToolbarItemType.allCases), withFlexibleSpace: insertingFlexibleSpace)
	}
}
