//
//  UIBarButtonItem+Extension.swift
//  COMIKit
//

import UIKit

public extension UIBarButtonItem {
	class func flexibleSpace() -> UIBarButtonItem {
		UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
	}

	class func fixedSpace(width: CGFloat) -> UIBarButtonItem {
		let buttonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
		buttonItem.width = width
		return buttonItem
	}
}
