import UIKit

@available(iOS 10.0, *)
struct FeedbackGenerator {
	
	static func impactOcurredWith(style: UIImpactFeedbackGenerator.FeedbackStyle) {
		if UserDefaultsManager.hapticFeedbackSwitchIsOn {
			UIImpactFeedbackGenerator(style: style).impactOccurred()
		}
	}
	
	static func notificationOcurredOf(type: UINotificationFeedbackGenerator.FeedbackType) {
		if UserDefaultsManager.hapticFeedbackSwitchIsOn {
			UINotificationFeedbackGenerator().notificationOccurred(type)
		}
	}
	
	static func selectionChanged() {
		if UserDefaultsManager.hapticFeedbackSwitchIsOn {
			UISelectionFeedbackGenerator().selectionChanged()
		}
	}
}