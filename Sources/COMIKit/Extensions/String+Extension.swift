//
//  String+Extension.swift
//  COMIKit
//

import Foundation

public extension String {
	var localized: String {
		return NSLocalizedString(self, comment: "")
	}
}
