//
//  EmptyDataView.swift
//  COMIKit
//

import SwiftUI

public struct EmptyDataView: View {
	public var title: String
	public var description: String?
	public var buttonTitle: String?
	public var buttonAction: (() -> Void)?

	public init(title: String, description: String? = nil, buttonTitle: String? = nil, buttonAction: (() -> Void)? = nil) {
		self.title = title
		self.description = description
		self.buttonTitle = buttonTitle
		self.buttonAction = buttonAction
	}

	public var body: some View {
		VStack(alignment: .center, spacing: 12) {
			Text(title)
				.font(.title)
				.bold()
			if let description = description {
				Text(description)
					.font(.body)
					.foregroundColor(.secondary)
			}
			if let buttonTitle = buttonTitle {
				Button {
					self.buttonAction?()
				} label: {
					Text(buttonTitle)
						.font(.body)
				}
			}
		}.padding()
	}
}
