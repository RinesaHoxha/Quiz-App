
import UIKit

extension UIView {
	
	func dontInvertIfDarkModeIsEnabled() {
		if #available(iOS 11.0, *) {
			self.accessibilityIgnoresInvertColors = UserDefaultsManager.darkThemeSwitchIsOn
		}
	}
	
	func dontInvertColors() {
		if #available(iOS 11.0, *) {
			self.accessibilityIgnoresInvertColors = true
		}
	}
}