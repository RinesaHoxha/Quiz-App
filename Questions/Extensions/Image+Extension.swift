import UIKit

/*extension UIImage {
	static func manageContentsOf(_ url: URL?, completionHandler: @escaping ((UIImage, URL?) -> ()), errorHandler: (() -> ())? = nil) {
		DownloadManager.shared.manageData(from: url) { data in
			if let data = data, let validImage = UIImage(data: data) {
				DispatchQueue.main.async {
					completionHandler(validImage, url)
				}
			} else {
				DispatchQueue.main.async {
					errorHandler?()
				}
			}
		}
	}
}*/