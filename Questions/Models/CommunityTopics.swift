import Foundation

struct CommunityTopic: Codable {
	let name: String?
	let remoteContentURL: URL
	var isVisible: Bool
}

struct CommunityTopics: Codable {
	
	var topics: [CommunityTopic] = []
	
	static var shared = CommunityTopics()
	
	static func initialize(completionHandler: ((CommunityTopics?) -> ())? = nil) {
		
		guard let url = URL(string: QuestionsAppOptions.communityTopicsURL) else { return }
		
		DownloadManager.shared.manageData(from: url, onSuccess: { data in
			if let communityTopics = try? JSONDecoder().decode(CommunityTopics.self, from: data) {
				CommunityTopics.shared.topics = communityTopics.topics
			}
			completionHandler?(CommunityTopics.shared)
		})
	}
}