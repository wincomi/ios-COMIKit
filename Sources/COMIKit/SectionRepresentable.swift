//
//  SectionRepresentable.swift
//  COMIKit
//

import UIKit

public protocol SectionRepresentable {
	associatedtype Row: RowRepresentable

	var headerText: String? { get }
	var footerText: String? { get }
	var rows: [Row] { get }
}
