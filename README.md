# Swift Console Networking on Windows 🚀

Hi 👋

This repository is a **learning-first Swift console project** created on **Windows**, focused on understanding how networking works in Swift **from scratch**, without SwiftUI or iOS UI frameworks.

This project is especially useful for:

* Anyone curious about using Swift on Windows

The goal is **clarity over cleverness**.

---

## 📌 What I learned while working on this Project

* Setting up a **Swift console app on Windows**
* Making a **network API call** using `URLSession`
* Parsing JSON using `Codable`
* Learning how **@MainActor**, `Sendable`, and concurrency errors work
* Printing API data in the console
* Debugging common Swift concurrency issues

---

## 🧠 Why Console App?

Before jumping into SwiftUI or iOS apps, it’s important to understand:

* How networking actually works
* What threads are
* Why async code behaves differently

Console apps remove UI complexity and let us **focus on fundamentals**.

---

## 📦 API Used

I used the free testing API:

```/
<https://jsonplaceholder.typicode.com/posts>
```

It returns an array of posts like this:

```json
{
  "userId": 1,
  "id": 1,
  "title": "Sample Title",
  "body": "Sample Body"
}
```

---

## 🧱 Data Model

```swift
used QUICKTYPE.io to extract data from the json response
struct PostData: Codable {
    let userID, id: Int?
    let title, body: String?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
```

---

## 🧠 ViewModel (Completion-Based Networking)

Intentionally used **completion handlers** instead of `async/await` to understand legacy Swift code first.
Might update in future to `async/await`

```swift
@MainActor
class DownloadingPostDataVM {

    The viewModal class which handles the Data downloading logic
}
```

---

## 🏁 Main Entry Point (`@main`)

In a console app, **the program exits immediately** unless we keep it alive.

That’s why we use:

```swift
RunLoop.main.run()
```

### `main.swift`

```swift
@main
struct Networking_Practice {
    the Main struct where app starts and Recived data gets printed to the console
}
```

---

## ❗ Errors I Faced (And What I Learned)

### ❌ Error: `Capture of 'completion' with non-Sendable type`

**Why it happened:**

* `Task {}` closures are `@Sendable`
* Completion handlers are NOT Sendable by default

**Fix:**

```swift
func getPostData(completion: @MainActor @escaping () -> Void)
```

This ensures the completion always runs on the main thread.

---

### ❌ Error: `Recv failure: Connection was reset`

**What happened:**

* I accidentally called the API **twice**
* Once inside `init()`
* Once inside `main`

**Lesson learned:**

`init` should only be used for setup, not side effects.

---

## 🧠 Key Concepts Learned

* Completion handlers
* Why console apps need a run loop
* Why `@MainActor` matters
* How Swift protects us using `Sendable`
* Why async/await exists (and why we learn callbacks first)

---

## 🚀 What’s Next

In the next iteration, this project will:

* Convert completions → `async/await`

---

## 🙌 Final Note

Take it step by step — this repo exists to prove that **learning deeply beats rushing**.

Happy coding! 👨‍💻👩‍💻
