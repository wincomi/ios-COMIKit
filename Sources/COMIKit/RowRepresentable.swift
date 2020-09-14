import UIKit

protocol RowRepresentable {
	var title: String { get }
	var description: String? { get }
	var image: UIImage? { get }
}
