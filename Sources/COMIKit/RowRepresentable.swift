//
//  RowRepresentable.swift
//  COMIKit
//

import UIKit

public protocol RowRepresentable {
	var text: String { get }
	var secondaryText: String? { get }
	var image: UIImage? { get }
}
