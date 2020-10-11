//
//  ListDataSourceRenderable.swift
//  COMIKit
//

import UIKit

public protocol ListDataSourceRenderable {
	associatedtype Section: SectionRepresentable & Hashable where Section.Row: Hashable
	typealias DataSource = ListDataSource<Section>

	var dataSource: DataSource { get set }
}
