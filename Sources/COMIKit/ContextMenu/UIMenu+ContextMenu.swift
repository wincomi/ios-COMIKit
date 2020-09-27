//
//  UIMenu+ContextMenu.swift
//  COMIKit
//

import UIKit

public extension UIMenu {
	convenience init(contextMenuItems: [ContextMenuItem], title: String = "", image: UIImage? = nil, identifier: UIMenu.Identifier? = nil) {
		self.init(title: title, image: image, identifier: identifier, options: [], children: contextMenuItems.map(\.uiMenuElement))
	}
}
