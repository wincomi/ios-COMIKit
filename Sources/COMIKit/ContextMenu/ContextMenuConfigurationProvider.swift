//
//  ContextMenuConfigurationProvider.swift
//  COMIKit
//

import UIKit

public protocol ContextMenuConfigurationProvider {
	associatedtype ContextMenuItemType
	func menuElement(for type: ContextMenuItemType) -> UIMenuElement?
	func menuElements(for types: [ContextMenuItemType]) -> [UIMenuElement]
	func contextMenuConfiguration(for types: [ContextMenuItemType]) -> UIContextMenuConfiguration
}

public extension ContextMenuConfigurationProvider {
	func menuElements(for types: [ContextMenuItemType]) -> [UIMenuElement] {
		return types.compactMap(menuElement(for:))
	}

	func contextMenuConfiguration(for contextMenuItemTypes: [ContextMenuItemType]) -> UIContextMenuConfiguration {
		return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
			UIMenu(title: "", image: nil, identifier: nil, children: menuElements(for: contextMenuItemTypes))
		}
	}
}

public extension ContextMenuConfigurationProvider where ContextMenuItemType: CaseIterable {
	func menuElements() -> [UIMenuElement] {
		return menuElements(for: Array(ContextMenuItemType.allCases))
	}

	func contextMenuConfiguration() -> UIContextMenuConfiguration {
		return contextMenuConfiguration(for: Array(ContextMenuItemType.allCases))
	}
}
