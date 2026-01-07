import UIKit
import SwiftUI

/// Toast position on the screen
public enum ToastPosition {
    case top
    case center
    case bottom
}

/// Toast style with predefined colors and icons
public enum ToastStyle {
    case success
    case error
    case warning
    case info
    case custom(backgroundColor: UIColor, textColor: UIColor, icon: UIImage?)

    var backgroundColor: UIColor {
        switch self {
        case .success: return UIColor.systemGreen
        case .error: return UIColor.systemRed
        case .warning: return UIColor.systemOrange
        case .info: return UIColor.systemBlue
        case .custom(let bgColor, _, _): return bgColor
        }
    }

    var textColor: UIColor {
        switch self {
        case .success, .error, .warning, .info: return .white
        case .custom(_, let txtColor, _): return txtColor
        }
    }

    var icon: UIImage? {
        switch self {
        case .success: return UIImage(systemName: "checkmark.circle.fill")
        case .error: return UIImage(systemName: "xmark.circle.fill")
        case .warning: return UIImage(systemName: "exclamationmark.triangle.fill")
        case .info: return UIImage(systemName: "info.circle.fill")
        case .custom(_, _, let customIcon): return customIcon
        }
    }
}

/// Main Toast class for displaying toast messages
public class Toast {

    /// Shared instance for easy access
    public static let shared = Toast()

    private init() {}

    /// Show a toast message
    /// - Parameters:
    ///   - message: The message to display
    ///   - style: The style of the toast (default: .info)
    ///   - position: The position on screen (default: .bottom)
    ///   - duration: How long to display the toast in seconds (default: 2.0)
    ///   - haptic: Whether to provide haptic feedback (default: true)
    public func show(
        message: String,
        style: ToastStyle = .info,
        position: ToastPosition = .bottom,
        duration: TimeInterval = 2.0,
        haptic: Bool = true
    ) {
        DispatchQueue.main.async {
            guard let window = self.getKeyWindow() else { return }

            if haptic {
                self.performHaptic(for: style)
            }

            let toastView = self.createToastView(
                message: message,
                style: style,
                in: window
            )

            window.addSubview(toastView)

            self.positionToast(toastView, at: position, in: window)

            self.animateToast(toastView, duration: duration)
        }
    }

    /// Show a success toast
    public func success(_ message: String, duration: TimeInterval = 2.0) {
        show(message: message, style: .success, duration: duration)
    }

    /// Show an error toast
    public func error(_ message: String, duration: TimeInterval = 2.0) {
        show(message: message, style: .error, duration: duration)
    }

    /// Show a warning toast
    public func warning(_ message: String, duration: TimeInterval = 2.0) {
        show(message: message, style: .warning, duration: duration)
    }

    /// Show an info toast
    public func info(_ message: String, duration: TimeInterval = 2.0) {
        show(message: message, style: .info, duration: duration)
    }

    // MARK: - Private Methods

    private func getKeyWindow() -> UIWindow? {
        if #available(iOS 15.0, *) {
            return UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        }
    }

    private func createToastView(
        message: String,
        style: ToastStyle,
        in window: UIWindow
    ) -> UIView {
        let toastView = UIView()
        toastView.backgroundColor = style.backgroundColor
        toastView.layer.cornerRadius = 12
        toastView.clipsToBounds = true
        toastView.alpha = 0

        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false

        if let icon = style.icon {
            let iconView = UIImageView(image: icon)
            iconView.tintColor = style.textColor
            iconView.contentMode = .scaleAspectFit
            iconView.translatesAutoresizingMaskIntoConstraints = false
            iconView.widthAnchor.constraint(equalToConstant: 24).isActive = true
            iconView.heightAnchor.constraint(equalToConstant: 24).isActive = true
            stackView.addArrangedSubview(iconView)
        }

        let label = UILabel()
        label.text = message
        label.textColor = style.textColor
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .left
        stackView.addArrangedSubview(label)

        toastView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: toastView.topAnchor, constant: 12),
            stackView.bottomAnchor.constraint(equalTo: toastView.bottomAnchor, constant: -12),
            stackView.leadingAnchor.constraint(equalTo: toastView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: toastView.trailingAnchor, constant: -16)
        ])

        toastView.translatesAutoresizingMaskIntoConstraints = false

        let maxWidth = window.bounds.width - 40
        NSLayoutConstraint.activate([
            toastView.leadingAnchor.constraint(greaterThanOrEqualTo: window.leadingAnchor, constant: 20),
            toastView.trailingAnchor.constraint(lessThanOrEqualTo: window.trailingAnchor, constant: -20),
            toastView.centerXAnchor.constraint(equalTo: window.centerXAnchor),
            toastView.widthAnchor.constraint(lessThanOrEqualToConstant: maxWidth)
        ])

        return toastView
    }

    private func positionToast(_ toastView: UIView, at position: ToastPosition, in window: UIWindow) {
        let safeArea = window.safeAreaInsets

        switch position {
        case .top:
            toastView.topAnchor.constraint(
                equalTo: window.topAnchor,
                constant: safeArea.top + 20
            ).isActive = true

        case .center:
            toastView.centerYAnchor.constraint(equalTo: window.centerYAnchor).isActive = true

        case .bottom:
            toastView.bottomAnchor.constraint(
                equalTo: window.bottomAnchor,
                constant: -(safeArea.bottom + 20)
            ).isActive = true
        }
    }

    private func animateToast(_ toastView: UIView, duration: TimeInterval) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            toastView.alpha = 1.0
            toastView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        } completion: { _ in
            UIView.animate(withDuration: 0.3, delay: duration, options: .curveEaseIn) {
                toastView.alpha = 0.0
            } completion: { _ in
                toastView.removeFromSuperview()
            }
        }
    }

    private func performHaptic(for style: ToastStyle) {
        switch style {
        case .success:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        case .error:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        case .warning:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
        case .info, .custom:
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
    }
}

// MARK: - SwiftUI Support

@available(iOS 13.0, *)
public struct ToastModifier: ViewModifier {
    @Binding var isPresented: Bool
    let message: String
    let style: ToastStyle
    let position: ToastPosition
    let duration: TimeInterval

    public func body(content: Content) -> some View {
        if #available(iOS 14.0, *) {
            content
                .onChange(of: isPresented) { newValue in
                    if newValue {
                        Toast.shared.show(
                            message: message,
                            style: style,
                            position: position,
                            duration: duration
                        )
                        DispatchQueue.main.asyncAfter(deadline: .now() + duration + 0.5) {
                            isPresented = false
                        }
                    }
                }
        } else {
            // Fallback on earlier versions
        }
    }
}

@available(iOS 13.0, *)
extension View {
    /// Display a toast message
    /// - Parameters:
    ///   - isPresented: Binding to control toast visibility
    ///   - message: The message to display
    ///   - style: The style of the toast
    ///   - position: The position on screen
    ///   - duration: How long to display the toast
    public func toast(
        isPresented: Binding<Bool>,
        message: String,
        style: ToastStyle = .info,
        position: ToastPosition = .bottom,
        duration: TimeInterval = 2.0
    ) -> some View {
        self.modifier(ToastModifier(
            isPresented: isPresented,
            message: message,
            style: style,
            position: position,
            duration: duration
        ))
    }
}
