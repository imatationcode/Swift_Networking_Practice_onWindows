// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import FoundationNetworking

@main
struct Networking_Practice {

    static func main() {

        print("Networking Practice Started.... 🚀")

        let vmVar = DownloadingPostDataVM()

        vmVar.getPostData {

            if let error = vmVar.errorMessage {
                print("❌ Error: \(error)")
                return
            }

            print("📦 Total Posts: \(vmVar.postArray.count)\n")

            for post in vmVar.postArray {
                print("""
                🧾 Post ID: \(post.id ?? 0)
                👤 User ID: \(post.userID ?? 0)
                🏷 Title: \(post.title ?? "")
                📝 Body: \(post.body ?? "")
                ---------------------------
                """)
            }

            print("✅ Finished Printing Posts")
        }

        // Keep the program alive (VERY IMPORTANT for console apps)
        RunLoop.main.run()// program won't exit automatically
    }
}
