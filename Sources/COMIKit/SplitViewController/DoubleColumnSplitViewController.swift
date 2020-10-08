//
//  DoubleColumnSplitViewController.swift
//  COMIKit
//

import UIKit

/// # Expanded Interface
/// Show primaryNavigation(with defaultViewController) + secondaryNavigation(with emptyViewController)
/// primaryNavigation viewControllers always have only one element which is primaryViewController
///
/// # Collapsed interface
/// Only show primaryNavigation(compactNavigation) without emptyViewController
/// emptyViewController is always hidden.
///
/// # Expanded interface to collapsed interface (Regular to Compact)
/// Current viewControllers of primaryNavigation and secondaryNavigation will be combined without emptyViewController in secondaryNavigation
///
/// # Collapsed interface to expanded interface (Compact to Regular)
/// Current viewControllers of primaryNavigation(compactNavigation) will be separated.
/// First viewController in primaryNavigation(compactNavigation) will be set to primaryNavigation
/// The others in primaryNavigation(compactNavigation) will be set to secondaryNavigation
/// If there is nothing left, emptyViewController will be set to secondaryNavigation.
///
/// setPrimaryViewController(_:) 등의 메소드는 expanded interface 기준으로 사용하면 collapsed interface에서도 적절하게 동작하도록 구성함.
open class DoubleColumnSplitViewController: UISplitViewController {
	/// In collapsed interface, primaryNavigation is used as compactNavigation
	public let primaryNavigation: UINavigationController

	/// In collapsed interface, secondaryNavigation is not used.
	public let secondaryNavigation: UINavigationController

	/// In collapsed interface, emptyViewController is not used.
	public var emptyViewController: UIViewController

	public init(primaryViewController: UIViewController, emptyViewController: UIViewController) {
		self.primaryNavigation = UINavigationController(rootViewController: primaryViewController)
		self.secondaryNavigation = UINavigationController(rootViewController: emptyViewController)
		self.emptyViewController = emptyViewController

		if #available(iOS 14.0, *) {
			super.init(style: .doubleColumn)
		} else {
			super.init(nibName: nil, bundle: nil)
		}
	}

	required public init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	open override func viewDidLoad() {
		super.viewDidLoad()

		delegate = self

		if #available(iOS 14.0, *) {
			preferredDisplayMode = .oneBesideSecondary
			preferredSplitBehavior = .tile
			setViewController(primaryNavigation, for: .primary)
			setViewController(secondaryNavigation, for: .secondary)
		} else {
			preferredDisplayMode = .allVisible
			viewControllers = [primaryNavigation, secondaryNavigation]
		}
	}

	// MARK: -
	public func setPrimaryViewController(_ vc: UIViewController) {
		primaryNavigation.viewControllers = [vc]
	}

	public func setSecondaryViewController(_ vc: UIViewController, animated: Bool = true) {
		if isCollapsed {
			primaryNavigation.pushViewController(vc, animated: animated)
		} else {
			secondaryNavigation.viewControllers = [vc]
		}
	}

	public func pushViewControllerInSecondaryNavigation(_ vc: UIViewController, animated: Bool) {
		if isCollapsed {
			primaryNavigation.pushViewController(vc, animated: animated)
		} else {
			secondaryNavigation.pushViewController(vc, animated: animated)
		}
	}
}

extension DoubleColumnSplitViewController: UISplitViewControllerDelegate {
	// MARK: - Collapsing the interface (Regular to Compact)
	@available(iOS 14.0, *)
	public func splitViewController(_ svc: UISplitViewController, topColumnForCollapsingToProposedTopColumn proposedTopColumn: UISplitViewController.Column) -> UISplitViewController.Column {
		setNavigationStackForCollapsing()

		return .primary
	}

	public func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
		setNavigationStackForCollapsing()

		// show primaryViewController of splitViewController
 		return true
	}

	private func setNavigationStackForCollapsing() {
		let currentPrimaryNavigationStack = primaryNavigation.viewControllers
		let currentSecondaryNavigationStack = secondaryNavigation.viewControllers
		primaryNavigation.viewControllers = []
		secondaryNavigation.viewControllers = []

		// 이 메소드에서는 splitViewController의 viewControllers을 직접 세팅하는 것이 안되므로 primaryNavigation의 viewControllers를 세팅하도록 하자.
		// secondaryNavigation의 topViewController가 emptyViewController일 경우 primaryNavigation에 currentSecondaryNavigationStack를 제외하고 세팅한다.
		if currentSecondaryNavigationStack.last == emptyViewController {
			primaryNavigation.viewControllers = currentPrimaryNavigationStack
		} else {
			primaryNavigation.viewControllers = currentPrimaryNavigationStack + currentSecondaryNavigationStack
		}
	}

	// MARK: - Expanding the interface (Compact to Regular)
	@available(iOS 14.0, *)
	public func splitViewController(_ svc: UISplitViewController, displayModeForExpandingToProposedDisplayMode proposedDisplayMode: UISplitViewController.DisplayMode) -> UISplitViewController.DisplayMode {
		setNavigationStackForExpanding()

		return .oneBesideSecondary
	}

	public func splitViewController(_ splitViewController: UISplitViewController, separateSecondaryFrom primaryViewController: UIViewController) -> UIViewController? {
		setNavigationStackForExpanding()

		return secondaryNavigation
	}

	private func setNavigationStackForExpanding() {
		let currentNavigationStack = primaryNavigation.viewControllers
		primaryNavigation.viewControllers = []

		primaryNavigation.viewControllers = [currentNavigationStack[0]]
		if currentNavigationStack.count == 1 {
			secondaryNavigation.viewControllers = [emptyViewController]
		} else {
			secondaryNavigation.viewControllers = Array(currentNavigationStack[1...])
		}
	}
}
