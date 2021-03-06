//
//  ContextMenuItem.swift
//  COMIKit
//

import UIKit

public struct ContextMenuItem {
	public enum Style {
		case `default`
		case destructive
	}

	public var title: String
	public var image: UIImage?
	public var discoverabilityTitle: String? = nil

	public var style: Style = .default
	public var isEnabled: Bool = true

	public var children: [ContextMenuItem] = []

	/// handler not working when it has children
	public var handler: (() -> Void)? = nil

	// MARK: - Initialization
	public init(title: String, image: UIImage? = nil, discoverabilityTitle: String? = nil, style: Style = .default, isEnabled: Bool = true, children: [ContextMenuItem] = [], handler: (() -> Void)? = nil) {
		self.title = title
		self.image = image
		self.discoverabilityTitle = discoverabilityTitle
		self.style = style
		self.isEnabled = isEnabled
		self.children = children
		self.handler = handler
	}

	// MARK: - Supporting UIMenu
	public func uiAction(state: UIMenuElement.State = .off, identifier: UIAction.Identifier? = nil) -> UIAction {
		UIAction(title: title, image: image, identifier: identifier, discoverabilityTitle: discoverabilityTitle, attributes: uiMenuElementAttributes, state: state) { _ in
			self.handler?()
		}
	}

	public var uiMenuElement: UIMenuElement {
		guard !children.isEmpty else { return uiAction() }
		return UIMenu(title: title, image: image, options: uiMenuOptions, children: children.map(\.uiMenuElement))
	}

	private var uiMenuElementAttributes: UIMenuElement.Attributes {
		if !isEnabled {
			return .disabled
		} else {
			return (style == .destructive) ? .destructive : UIMenuElement.Attributes()
		}
	}

	private var uiMenuOptions: UIMenu.Options {
		(style == .destructive) ? .destructive : .init()
	}

	// MARK: - Supporting UIAlertController
	public func uiAlertAction(childrenHandler: (([ContextMenuItem]) -> Void)? = nil) -> UIAlertAction {
		let action = UIAlertAction(title: title, style: uiAlertActionStyle) { _ in
			guard self.children.isEmpty else {
				childrenHandler?(self.children)
				return
			}
			self.handler?()
		}
		action.image = image
		action.isEnabled = isEnabled
		return action
	}

	private var uiAlertActionStyle: UIAlertAction.Style {
		(style == .destructive) ? .destructive : .default
	}
}
