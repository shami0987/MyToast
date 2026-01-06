# MyToast

A lightweight, customizable Toast notification library for iOS written in Swift. Supports both UIKit and SwiftUI with beautiful animations and haptic feedback.

## Features

- Simple and easy to use API
- Support for both UIKit and SwiftUI
- Multiple toast styles (success, error, warning, info, custom)
- Customizable position (top, center, bottom)
- Haptic feedback support
- Smooth animations
- SF Symbols icons
- Dark mode compatible
- iOS 13+ support

## Installation

### Swift Package Manager

Add MyToast to your project using Swift Package Manager:

#### Xcode
1. File > Add Package Dependencies
2. Enter the repository URL: `https://github.com/YOUR_USERNAME/MyToast.git`
3. Select the version you want to use
4. Click "Add Package"

#### Package.swift
Add MyToast as a dependency in your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/YOUR_USERNAME/MyToast.git", from: "1.0.0")
]
```

Then add it to your target:

```swift
targets: [
    .target(
        name: "YourTarget",
        dependencies: ["MyToast"]
    )
]
```

## Usage

### UIKit

Import the library:

```swift
import MyToast
```

#### Basic Usage

```swift
// Show a simple info toast
Toast.shared.info("This is an info message")

// Show a success toast
Toast.shared.success("Operation completed successfully!")

// Show an error toast
Toast.shared.error("Something went wrong")

// Show a warning toast
Toast.shared.warning("Please check your input")
```

#### Advanced Usage

```swift
// Custom configuration
Toast.shared.show(
    message: "Custom toast message",
    style: .success,
    position: .top,
    duration: 3.0,
    haptic: true
)

// Custom style with your own colors and icon
Toast.shared.show(
    message: "Custom styled toast",
    style: .custom(
        backgroundColor: .systemPurple,
        textColor: .white,
        icon: UIImage(systemName: "star.fill")
    ),
    position: .center,
    duration: 2.5
)
```

#### In View Controllers

```swift
import UIKit
import MyToast

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func showToastButtonTapped(_ sender: UIButton) {
        Toast.shared.success("Button tapped!")
    }

    func saveData() {
        // Your save logic
        Toast.shared.success("Data saved successfully")
    }

    func handleError() {
        Toast.shared.error("Failed to load data")
    }
}
```

### SwiftUI

Import the library:

```swift
import SwiftUI
import MyToast
```

#### Using Toast Modifier

```swift
struct ContentView: View {
    @State private var showToast = false

    var body: some View {
        VStack {
            Button("Show Toast") {
                showToast = true
            }
        }
        .toast(
            isPresented: $showToast,
            message: "This is a toast message!",
            style: .success,
            position: .bottom,
            duration: 2.0
        )
    }
}
```

#### Direct Usage

```swift
struct ContentView: View {
    var body: some View {
        VStack {
            Button("Show Success") {
                Toast.shared.success("Operation successful!")
            }

            Button("Show Error") {
                Toast.shared.error("An error occurred")
            }

            Button("Show Warning") {
                Toast.shared.warning("Warning message")
            }

            Button("Show Info") {
                Toast.shared.info("Information message")
            }
        }
    }
}
```

## API Reference

### Toast Styles

```swift
public enum ToastStyle {
    case success    // Green background with checkmark icon
    case error      // Red background with X icon
    case warning    // Orange background with exclamation icon
    case info       // Blue background with info icon
    case custom(backgroundColor: UIColor, textColor: UIColor, icon: UIImage?)
}
```

### Toast Positions

```swift
public enum ToastPosition {
    case top       // Appears at the top of the screen
    case center    // Appears in the center of the screen
    case bottom    // Appears at the bottom of the screen
}
```

### Main Methods

```swift
// Show a toast with full customization
Toast.shared.show(
    message: String,
    style: ToastStyle = .info,
    position: ToastPosition = .bottom,
    duration: TimeInterval = 2.0,
    haptic: Bool = true
)

// Convenience methods
Toast.shared.success(_ message: String, duration: TimeInterval = 2.0)
Toast.shared.error(_ message: String, duration: TimeInterval = 2.0)
Toast.shared.warning(_ message: String, duration: TimeInterval = 2.0)
Toast.shared.info(_ message: String, duration: TimeInterval = 2.0)
```

## Requirements

- iOS 13.0+
- Swift 5.9+
- Xcode 15.0+

## Examples

### Network Request with Toast

```swift
func fetchData() {
    URLSession.shared.dataTask(with: url) { data, response, error in
        DispatchQueue.main.async {
            if let error = error {
                Toast.shared.error("Network error: \(error.localizedDescription)")
                return
            }

            Toast.shared.success("Data loaded successfully")
        }
    }.resume()
}
```

### Form Validation

```swift
func validateAndSubmit() {
    guard !emailTextField.text.isEmpty else {
        Toast.shared.warning("Please enter your email")
        return
    }

    guard !passwordTextField.text.isEmpty else {
        Toast.shared.warning("Please enter your password")
        return
    }

    // Submit form
    Toast.shared.success("Form submitted!")
}
```

### Custom Themed Toast

```swift
let customStyle = ToastStyle.custom(
    backgroundColor: UIColor(red: 0.2, green: 0.2, blue: 0.3, alpha: 1.0),
    textColor: .white,
    icon: UIImage(systemName: "flame.fill")
)

Toast.shared.show(
    message: "Custom themed message",
    style: customStyle,
    position: .top,
    duration: 3.0
)
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

Your Name - [@YourTwitterHandle](https://twitter.com/YourTwitterHandle)

Project Link: [https://github.com/YOUR_USERNAME/MyToast](https://github.com/YOUR_USERNAME/MyToast)

## Acknowledgments

- Inspired by various toast libraries in the iOS community
- Built with love using Swift and SwiftUI
