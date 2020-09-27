//
//  UIAlertController+ContextMenu.swift
//  COMIKit
//

import UIKit

public extension UIAlertController {
	convenience init(contextMenuItems: [ContextMenuItem], title: String? = nil, message: String? = nil, preferredStyle: UIAlertController.Style = .actionSheet, childrenHandler: (([ContextMenuItem]) -> Void)? = nil) {
		self.init(title: title, message: message, preferredStyle: preferredStyle)
		addAction(.cancelAction())

		let alertActions = contextMenuItems.map { $0.uiAlertAction(childrenHandler: childrenHandler) }
		alertActions.forEach { action in
			addAction(action)
		}
	}
}
