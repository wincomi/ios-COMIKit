import UIKit

public extension UIAlertAction {
	var image: UIImage? {
		get {
			value(forKey: "image") as? UIImage
		}

		set {
			setValue(newValue, forKey: "image")
		}
	}

	class func cancelAction(handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
		UIAlertAction(title: "Cancel".localized, style: .cancel, handler: handler)
	}
	
	class func okAction(handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
		UIAlertAction(title: "OK".localized, style: .default, handler: handler)
	}
}
