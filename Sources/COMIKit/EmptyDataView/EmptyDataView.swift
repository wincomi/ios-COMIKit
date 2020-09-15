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

	public var body: some View {
		VStack(alignment: .center, spacing: 12) {
			Text(title)
				.font(.title)
				.bold()
			description.map { description in
				Text(description)
					.font(.body)
					.foregroundColor(.secondary)
			}
			buttonTitle.map { buttonTitle in
				Button(action: {
					self.buttonAction?()
				}) {
					Text(buttonTitle)
						.font(.body)
				}
			}
		}
    }
}
