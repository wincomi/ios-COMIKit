//
//  UIBarButtonItem+ContextMenu.swift
//  COMIKit
//

import UIKit

public extension UIBarButtonItem {
	private struct AssociatedObject {
		static var handlerKey = "COMIKIT_ACTION_HANDLER_KEY"
		static var contextMenuKey = "COMIKIT_CONTEXT_MENU_KEY"
	}

	typealias UIBarbuttonItemHandler = (() -> Void)
	typealias ContextMenuItemsHandler = (([ContextMenuItem]) -> Void)

	private var _handler: UIBarbuttonItemHandler? {
		get {
			objc_getAssociatedObject(self, &AssociatedObject.handlerKey) as? UIBarbuttonItemHandler
		}
		set {
			objc_setAssociatedObject(self, &AssociatedObject.handlerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
			target = self
			action = #selector(action(sender:))
		}
	}

	private var _contextMenuItems: [ContextMenuItem]? {
		get {
			objc_getAssociatedObject(self, &AssociatedObject.contextMenuKey) as? [ContextMenuItem]
		}
		set {
			objc_setAssociatedObject(self, &AssociatedObject.contextMenuKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}

	@objc private func action(sender: UIBarButtonItem) {
		_handler?()
	}

	// MARK: - Initialization
	convenience init(title: String? = nil, image: UIImage? = nil, contextMenuItems: [ContextMenuItem]? = nil, contextMenuItemsHandler: ContextMenuItemsHandler? = nil, handler: UIBarbuttonItemHandler? = nil) {
		if #available(iOS 14.0, *)  {
			let primaryAction = handler.map { handler in
				UIAction(title: title ?? "") { _ in handler() }
			}

			var menu: UIMenu?
			if let contextMenuItems = contextMenuItems {
				menu = UIMenu(contextMenuItems: contextMenuItems)
			}

			self.init(title: title, image: image, primaryAction: primaryAction, menu: menu)
		} else {
			self.init(image: image, style: .plain, target: nil, action: nil)
			self.title = title
			self._contextMenuItems = contextMenuItems
			self._handler = {
				if let contextMenuItems = contextMenuItems {
					guard let contextMenuItemsHandler = contextMenuItemsHandler else {
						print("Warning: Required contextMenuItemsHandler under iOS 14\n\(self.debugDescription)")
						return nil
					}
					return { contextMenuItemsHandler(contextMenuItems) }
				} else {
					return handler
				}
			}()
		}
	}
}
