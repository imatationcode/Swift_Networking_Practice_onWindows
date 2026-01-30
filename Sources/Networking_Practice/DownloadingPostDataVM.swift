import Foundation
import FoundationNetworking

@MainActor
class DownloadingPostDataVM {

    var postArray: [PostData] = []
    var isLoading = false
    var errorMessage: String?

    init() {
    }

    func getPostData(completion: @MainActor @escaping () -> Void) {

        isLoading = true
        errorMessage = nil

        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            errorMessage = "Invalid URL"
            isLoading = false
            completion()
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in

            // Hop back to MainActor explicitly
            Task { @MainActor in
                self.isLoading = false
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    completion()
                    return
                }

                guard let data = data else {
                    self.errorMessage = "No data received"
                    completion()
                    return
                }

                do {
                    self.postArray = try JSONDecoder().decode([PostData].self, from: data)
                    print("✅ Data decoded successfully")
                } catch {
                    self.errorMessage = error.localizedDescription
                }

                completion()
            }

        }.resume()
    }
}
