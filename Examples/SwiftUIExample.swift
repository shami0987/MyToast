import SwiftUI
import MyToast

/// Example SwiftUI View showing various Toast usage patterns
@available(iOS 13.0, *)
struct ToastExampleView: View {
    @State private var showSuccessToast = false
    @State private var showErrorToast = false
    @State private var showWarningToast = false
    @State private var showInfoToast = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Toast Examples")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top)

                    // Using Toast Modifier
                    Group {
                        Text("Using Toast Modifier")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)

                        Button("Show Success Toast") {
                            showSuccessToast = true
                        }
                        .buttonStyle(ToastButtonStyle(color: .green))
                        .toast(
                            isPresented: $showSuccessToast,
                            message: "Operation completed successfully!",
                            style: .success,
                            position: .bottom,
                            duration: 2.0
                        )

                        Button("Show Error Toast") {
                            showErrorToast = true
                        }
                        .buttonStyle(ToastButtonStyle(color: .red))
                        .toast(
                            isPresented: $showErrorToast,
                            message: "Something went wrong!",
                            style: .error
                        )

                        Button("Show Warning Toast") {
                            showWarningToast = true
                        }
                        .buttonStyle(ToastButtonStyle(color: .orange))
                        .toast(
                            isPresented: $showWarningToast,
                            message: "Please check your input",
                            style: .warning
                        )

                        Button("Show Info Toast") {
                            showInfoToast = true
                        }
                        .buttonStyle(ToastButtonStyle(color: .blue))
                        .toast(
                            isPresented: $showInfoToast,
                            message: "Here's some information",
                            style: .info
                        )
                    }

                    Divider()
                        .padding()

                    // Direct Toast Usage
                    Group {
                        Text("Direct Toast Usage")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)

                        Button("Success (Direct)") {
                            Toast.shared.success("Success message!")
                        }
                        .buttonStyle(ToastButtonStyle(color: .green))

                        Button("Error (Direct)") {
                            Toast.shared.error("Error message!")
                        }
                        .buttonStyle(ToastButtonStyle(color: .red))

                        Button("Warning (Direct)") {
                            Toast.shared.warning("Warning message!")
                        }
                        .buttonStyle(ToastButtonStyle(color: .orange))

                        Button("Info (Direct)") {
                            Toast.shared.info("Info message!")
                        }
                        .buttonStyle(ToastButtonStyle(color: .blue))
                    }

                    Divider()
                        .padding()

                    // Position Examples
                    Group {
                        Text("Position Examples")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)

                        Button("Toast at Top") {
                            Toast.shared.show(
                                message: "This appears at the top",
                                style: .success,
                                position: .top
                            )
                        }
                        .buttonStyle(ToastButtonStyle(color: .purple))

                        Button("Toast at Center") {
                            Toast.shared.show(
                                message: "This appears in the center",
                                style: .info,
                                position: .center
                            )
                        }
                        .buttonStyle(ToastButtonStyle(color: .indigo))

                        Button("Toast at Bottom") {
                            Toast.shared.show(
                                message: "This appears at the bottom",
                                style: .warning,
                                position: .bottom
                            )
                        }
                        .buttonStyle(ToastButtonStyle(color: .orange))
                    }

                    Divider()
                        .padding()

                    // Custom Examples
                    Group {
                        Text("Custom Examples")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)

                        Button("Custom Style") {
                            Toast.shared.show(
                                message: "Custom styled toast!",
                                style: .custom(
                                    backgroundColor: UIColor.systemPink,
                                    textColor: .white,
                                    icon: UIImage(systemName: "star.fill")
                                ),
                                position: .bottom,
                                duration: 3.0
                            )
                        }
                        .buttonStyle(ToastButtonStyle(color: .pink))

                        Button("Long Duration (5s)") {
                            Toast.shared.show(
                                message: "This toast stays for 5 seconds",
                                style: .info,
                                duration: 5.0
                            )
                        }
                        .buttonStyle(ToastButtonStyle(color: .teal))

                        Button("No Haptic Feedback") {
                            Toast.shared.show(
                                message: "No haptic feedback for this one",
                                style: .success,
                                haptic: false
                            )
                        }
                        .buttonStyle(ToastButtonStyle(color: .green))
                    }

                    Divider()
                        .padding()

                    // Real World Examples
                    Group {
                        Text("Real World Examples")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)

                        Button("Simulate Network Request") {
                            simulateNetworkRequest()
                        }
                        .buttonStyle(ToastButtonStyle(color: .blue))

                        Button("Simulate Form Validation") {
                            validateForm()
                        }
                        .buttonStyle(ToastButtonStyle(color: .orange))

                        Button("Simulate File Save") {
                            saveFile()
                        }
                        .buttonStyle(ToastButtonStyle(color: .green))
                    }

                    Spacer()
                        .frame(height: 40)
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    // MARK: - Real World Examples

    private func simulateNetworkRequest() {
        Toast.shared.info("Loading data...")

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let success = Bool.random()
            if success {
                Toast.shared.success("Data loaded successfully!")
            } else {
                Toast.shared.error("Network request failed")
            }
        }
    }

    private func validateForm() {
        let hasEmail = Bool.random()
        let hasPassword = Bool.random()

        if !hasEmail {
            Toast.shared.warning("Please enter your email")
            return
        }

        if !hasPassword {
            Toast.shared.warning("Please enter your password")
            return
        }

        Toast.shared.success("Form submitted successfully!")
    }

    private func saveFile() {
        Toast.shared.info("Saving file...")

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            Toast.shared.success("File saved successfully!")
        }
    }
}

// MARK: - Custom Button Style

@available(iOS 13.0, *)
struct ToastButtonStyle: ButtonStyle {
    let color: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(color)
            .cornerRadius(12)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
            .padding(.horizontal)
    }
}

// MARK: - Form Example View

@available(iOS 13.0, *)
struct FormExampleView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showToast = false
    @State private var toastMessage = ""
    @State private var toastStyle: ToastStyle = .info

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Login Form")) {
                    TextField("Email", text: $email)
                        .textContentType(.emailAddress)
                        .autocapitalization(.none)

                    SecureField("Password", text: $password)
                        .textContentType(.password)
                }

                Section {
                    Button("Submit") {
                        validateAndSubmit()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .navigationTitle("Form Example")
            .toast(
                isPresented: $showToast,
                message: toastMessage,
                style: toastStyle
            )
        }
    }

    private func validateAndSubmit() {
        guard !email.isEmpty else {
            showToastMessage("Please enter your email", style: .warning)
            return
        }

        guard email.contains("@") else {
            showToastMessage("Invalid email format", style: .error)
            return
        }

        guard !password.isEmpty else {
            showToastMessage("Please enter your password", style: .warning)
            return
        }

        guard password.count >= 8 else {
            showToastMessage("Password must be at least 8 characters", style: .error)
            return
        }

        showToastMessage("Login successful!", style: .success)
    }

    private func showToastMessage(_ message: String, style: ToastStyle) {
        toastMessage = message
        toastStyle = style
        showToast = true
    }
}

// MARK: - Preview

@available(iOS 13.0, *)
struct ToastExampleView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ToastExampleView()
                .previewDisplayName("Main Examples")

            FormExampleView()
                .previewDisplayName("Form Example")
        }
    }
}
