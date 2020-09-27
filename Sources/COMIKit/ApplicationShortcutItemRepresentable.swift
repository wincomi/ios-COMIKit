//
//  ApplicationShortcutItemRepresentable.swift
//  COMIKit
//

import UIKit

public protocol ApplicationShortcutItemRepresentable {
	var localizedTitle: String { get }
	var localizedSubtitle: String? { get }
	var type: String { get }
	var icon: UIApplicationShortcutIcon? { get }
}

public extension UIApplicationShortcutItem {
	convenience init(_ applicationShortcutItem: ApplicationShortcutItemRepresentable, userInfo: [String: NSSecureCoding]? = nil) {
		self.init(type: applicationShortcutItem.type, localizedTitle: applicationShortcutItem.localizedTitle, localizedSubtitle: applicationShortcutItem.localizedSubtitle, icon: applicationShortcutItem.icon, userInfo: userInfo)
	}
}
