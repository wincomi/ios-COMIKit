//
//  UIViewController+ContextMenu.swift
//  COMIKit
//

import UIKit

public extension UIViewController {
	func present(contextMenuItems: [ContextMenuItem]) {
		present(contextMenuItems: contextMenuItems, animated: true)
	}

	func present(contextMenuItems: [ContextMenuItem], animated: Bool, configurePopoverPresentationController: ((UIPopoverPresentationController) -> Void)? = nil) {
		let alert = UIAlertController(contextMenuItems: contextMenuItems, childrenHandler: present(contextMenuItems:))
		if let popoverPresentationController = alert.popoverPresentationController {
			configurePopoverPresentationController?(popoverPresentationController)
		}
		present(alert, animated: animated)
	}
}
