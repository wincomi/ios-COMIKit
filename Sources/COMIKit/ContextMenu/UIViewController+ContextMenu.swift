//
//  UIViewController+ContextMenu.swift
//  COMIKit
//

import UIKit

public extension UIViewController {
	func present(contextMenuItems: [ContextMenuItem]) {
		present(contextMenuItems: contextMenuItems, animated: true)
	}

	func present(contextMenuItems: [ContextMenuItem], animated: Bool) {
		let alert = UIAlertController(contextMenuItems: contextMenuItems, childrenHandler: present(contextMenuItems:))
		present(alert, animated: animated)
	}
}
