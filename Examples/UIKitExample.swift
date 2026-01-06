import UIKit
import MyToast

/// Example UIKit ViewController showing various Toast usage patterns
class ToastExampleViewController: UIViewController {

    // MARK: - UI Components
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Setup
    private func setupUI() {
        title = "Toast Examples"
        view.backgroundColor = .systemBackground

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        addButtons()
    }

    private func addButtons() {
        // Success Toast Button
        let successButton = createButton(
            title: "Show Success Toast",
            backgroundColor: .systemGreen
        ) { [weak self] in
            self?.showSuccessToast()
        }
        stackView.addArrangedSubview(successButton)

        // Error Toast Button
        let errorButton = createButton(
            title: "Show Error Toast",
            backgroundColor: .systemRed
        ) { [weak self] in
            self?.showErrorToast()
        }
        stackView.addArrangedSubview(errorButton)

        // Warning Toast Button
        let warningButton = createButton(
            title: "Show Warning Toast",
            backgroundColor: .systemOrange
        ) { [weak self] in
            self?.showWarningToast()
        }
        stackView.addArrangedSubview(warningButton)

        // Info Toast Button
        let infoButton = createButton(
            title: "Show Info Toast",
            backgroundColor: .systemBlue
        ) { [weak self] in
            self?.showInfoToast()
        }
        stackView.addArrangedSubview(infoButton)

        // Top Position Button
        let topButton = createButton(
            title: "Show Toast at Top",
            backgroundColor: .systemPurple
        ) { [weak self] in
            self?.showTopToast()
        }
        stackView.addArrangedSubview(topButton)

        // Center Position Button
        let centerButton = createButton(
            title: "Show Toast at Center",
            backgroundColor: .systemIndigo
        ) { [weak self] in
            self?.showCenterToast()
        }
        stackView.addArrangedSubview(centerButton)

        // Custom Style Button
        let customButton = createButton(
            title: "Show Custom Toast",
            backgroundColor: .systemPink
        ) { [weak self] in
            self?.showCustomToast()
        }
        stackView.addArrangedSubview(customButton)

        // Long Duration Button
        let longButton = createButton(
            title: "Show Long Duration Toast",
            backgroundColor: .systemTeal
        ) { [weak self] in
            self?.showLongDurationToast()
        }
        stackView.addArrangedSubview(longButton)
    }

    private func createButton(
        title: String,
        backgroundColor: UIColor,
        action: @escaping () -> Void
    ) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = backgroundColor
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 12
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true

        let buttonAction = UIAction { _ in action() }
        button.addAction(buttonAction, for: .touchUpInside)

        return button
    }

    // MARK: - Toast Examples
    private func showSuccessToast() {
        Toast.shared.success("Operation completed successfully!")
    }

    private func showErrorToast() {
        Toast.shared.error("Something went wrong. Please try again.")
    }

    private func showWarningToast() {
        Toast.shared.warning("Please check your input before proceeding")
    }

    private func showInfoToast() {
        Toast.shared.info("Did you know? You can customize toast styles!")
    }

    private func showTopToast() {
        Toast.shared.show(
            message: "This toast appears at the top",
            style: .success,
            position: .top
        )
    }

    private func showCenterToast() {
        Toast.shared.show(
            message: "This toast appears in the center",
            style: .info,
            position: .center
        )
    }

    private func showCustomToast() {
        Toast.shared.show(
            message: "This is a custom styled toast!",
            style: .custom(
                backgroundColor: UIColor.systemPink,
                textColor: .white,
                icon: UIImage(systemName: "star.fill")
            ),
            position: .bottom,
            duration: 3.0
        )
    }

    private func showLongDurationToast() {
        Toast.shared.show(
            message: "This toast will stay visible for 5 seconds",
            style: .info,
            position: .bottom,
            duration: 5.0
        )
    }
}

// MARK: - Real World Examples

extension ToastExampleViewController {

    /// Example: Network request with toast feedback
    func performNetworkRequest() {
        // Simulate network call
        URLSession.shared.dataTask(with: URL(string: "https://api.example.com/data")!) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    Toast.shared.error("Network error: \(error.localizedDescription)")
                    return
                }

                guard let data = data else {
                    Toast.shared.error("No data received")
                    return
                }

                Toast.shared.success("Data loaded successfully (\(data.count) bytes)")
            }
        }
    }

    /// Example: Form validation
    func validateAndSubmitForm(email: String, password: String) {
        guard !email.isEmpty else {
            Toast.shared.warning("Please enter your email")
            return
        }

        guard email.contains("@") else {
            Toast.shared.error("Invalid email format")
            return
        }

        guard !password.isEmpty else {
            Toast.shared.warning("Please enter your password")
            return
        }

        guard password.count >= 8 else {
            Toast.shared.error("Password must be at least 8 characters")
            return
        }

        Toast.shared.success("Form submitted successfully!")
    }

    /// Example: File save operation
    func saveFile() {
        do {
            // Simulate file save
            let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent("data.txt")
            try "Sample data".write(to: fileURL, atomically: true, encoding: .utf8)

            Toast.shared.success("File saved successfully")
        } catch {
            Toast.shared.error("Failed to save file: \(error.localizedDescription)")
        }
    }

    /// Example: Settings update
    func updateSettings(notifications enabled: Bool) {
        UserDefaults.standard.set(enabled, forKey: "notificationsEnabled")

        if enabled {
            Toast.shared.success("Notifications enabled")
        } else {
            Toast.shared.info("Notifications disabled")
        }
    }
}
