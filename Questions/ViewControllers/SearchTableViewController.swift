import UIKit

class SearchTableViewController: UITableViewController, UISearchControllerDelegate {
	
	var items: [SetOfTopics.Mode: [TopicEntry]] = [:]
	var parentVC: UIViewController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
		if UserDefaultsManager.darkThemeSwitchIsOn {
			self.loadCurrentTheme()
		}
    }
	
	private func loadCurrentTheme() {
		guard #available(iOS 13, *) else {
			self.tableView.backgroundColor = .themeStyle(dark: .black, light: .groupTableViewBackground)
			self.tableView.separatorColor = .themeStyle(dark: .black, light: .defaultSeparatorColor)
			return
		}
	}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
		return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if let mode = SetOfTopics.Mode(rawValue: section) {
			return self.items[mode]?.count ?? 0
		}
		return 0
    }
	
	override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
		guard #available(iOS 13, *) else {
			guard UserDefaultsManager.darkThemeSwitchIsOn else { return } // NOTE: could change depending on your theme settings!
			let header = view as? UITableViewHeaderFooterView
			header?.textLabel?.textColor = .themeStyle(dark: .lightGray, light: .gray)
			return
		}
	}
	
	override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		cell.textLabel?.font = .preferredFont(forTextStyle: .body)
		guard #available(iOS 13, *) else {
			cell.textLabel?.textColor = .themeStyle(dark: .white, light: .black)
			cell.tintColor = .themeStyle(dark: .orange, light: .defaultTintColor)
			if UserDefaultsManager.darkThemeSwitchIsOn { cell.backgroundColor = .veryDarkGray }
			return
		}
	}

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = UITableViewCell()

		if let mode = SetOfTopics.Mode(rawValue: indexPath.section), let topics = self.items[mode] {
			cell.textLabel?.text = topics[indexPath.row].displayedName.localized
		}
		
		if #available(iOS 13, *) {
			return cell
		}
		
		if UserDefaultsManager.darkThemeSwitchIsOn {
			let view = UIView()
			view.backgroundColor = UIColor.darkGray
			cell.selectedBackgroundView = view
		}
		
        return cell
    }
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		switch SetOfTopics.Mode(rawValue: section) {
		case .some(let sectionMode):
			switch sectionMode {
			case SetOfTopics.Mode.app: return L10n.Topics_AllTopics_Type_App
			case SetOfTopics.Mode.saved: return L10n.Topics_AllTopics_Type_Saved
			case SetOfTopics.Mode.community: return L10n.Topics_AllTopics_Type_Community
			}
		case .none:
			return nil
		}
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		var outputIndexPath = indexPath
		
		switch indexPath.section {
		case SetOfTopics.Mode.app.rawValue: outputIndexPath.row = SetOfTopics.shared.topicsEntry.firstIndex(of: self.items[.app]![indexPath.row])!
		case SetOfTopics.Mode.saved.rawValue: outputIndexPath.row = SetOfTopics.shared.savedTopics.firstIndex(of: self.items[.saved]![indexPath.row])!
		case SetOfTopics.Mode.community.rawValue: outputIndexPath.row = SetOfTopics.shared.communityTopics.firstIndex(of: self.items[.community]![indexPath.row])!
		default: break
		}
		
		if indexPath.section == SetOfTopics.Mode.community.rawValue, let tableVC = self.parentVC as? UITableViewController {
			tableVC.tableView(tableVC.tableView, didSelectRowAt: IndexPath(row: outputIndexPath.row, section: 0))
			return
		}
		
		self.parentVC?.performSegue(withIdentifier: "selectTopic", sender: outputIndexPath)
	}
}