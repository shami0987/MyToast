# MyToast Examples

This directory contains example code demonstrating how to use MyToast in your iOS applications.

## Files

### UIKitExample.swift
Complete UIKit example showing:
- Basic toast usage with all styles (success, error, warning, info)
- Different positions (top, center, bottom)
- Custom styled toasts
- Real-world use cases (network requests, form validation, file operations)

### SwiftUIExample.swift
Complete SwiftUI example showing:
- Using toast modifier for declarative UI
- Direct Toast API usage
- Form validation example
- Network request simulation
- Custom button styles

## How to Use These Examples

### For UIKit Projects

1. Copy the relevant code from `UIKitExample.swift` into your view controller
2. Import MyToast at the top of your file: `import MyToast`
3. Call the toast methods as needed

```swift
import MyToast

class YourViewController: UIViewController {
    func showToast() {
        Toast.shared.success("Hello from MyToast!")
    }
}
```

### For SwiftUI Projects

1. Copy the relevant code from `SwiftUIExample.swift` into your SwiftUI view
2. Import MyToast at the top of your file: `import MyToast`
3. Use either the modifier approach or direct API

```swift
import SwiftUI
import MyToast

struct YourView: View {
    @State private var showToast = false

    var body: some View {
        Button("Show Toast") {
            showToast = true
        }
        .toast(
            isPresented: $showToast,
            message: "Hello from MyToast!",
            style: .success
        )
    }
}
```

## Quick Reference

### Common Patterns

**Success Message:**
```swift
Toast.shared.success("Operation successful!")
```

**Error Message:**
```swift
Toast.shared.error("Something went wrong")
```

**Warning Message:**
```swift
Toast.shared.warning("Please check your input")
```

**Info Message:**
```swift
Toast.shared.info("Here's some information")
```

**Custom Position:**
```swift
Toast.shared.show(
    message: "Custom message",
    style: .success,
    position: .top
)
```

**Custom Style:**
```swift
Toast.shared.show(
    message: "Custom styled",
    style: .custom(
        backgroundColor: .systemPurple,
        textColor: .white,
        icon: UIImage(systemName: "star.fill")
    )
)
```

## Tips

- Use `.success` for completed actions
- Use `.error` for failures and errors
- Use `.warning` for validation issues
- Use `.info` for general information
- Keep messages concise (1-2 lines work best)
- Default duration is 2 seconds - adjust as needed
- Haptic feedback is enabled by default
