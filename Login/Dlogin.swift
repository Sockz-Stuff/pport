import SwiftUI
import Firebase

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showCreateAccountForm: Bool = false
    @State private var createAccountEmail: String = ""
    @State private var createAccountPassword: String = ""

    var body: some View {
        ZStack {
            VStack {
                TextField("Email or username", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 50)
                    .padding(.top, 50)

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 50)
                    .padding(.top, 20)

                Button("Login") {
                    Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                        if let error = error {
                            // Handle error if sign in failed
                            print("Sign in failed: \(error.localizedDescription)")
                        } else {
                            // Sign in succeeded, navigate to the main screen
                            navigateToMainScreen()
                        }
                    }
                }
                .buttonStyle(FilledButtonStyle())
                .padding(.top, 20)

                Button("Create account") {
                    showCreateAccountForm = true
                }
                .buttonStyle(FilledButtonStyle())
                .padding(.top, 20)

                Spacer()
            }
            .padding(.bottom, showCreateAccountForm ? 50 : 0)

            if showCreateAccountForm {
                VStack {
                    TextField("Email", text: $createAccountEmail)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 50)
                        .padding(.top, 50)

                    SecureField("Password", text: $createAccountPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 50)
                        .padding(.top, 20)

                    Button("Create account") {
                        Auth.auth().createUser(withEmail: createAccountEmail, password: createAccountPassword) { authResult, error in
                            if let error = error {
                                // Handle error if account creation failed
                                print("Account creation failed: \(error.localizedDescription)")
                            } else {
                                // Account creation succeeded, sign in the user and navigate to the main screen
                                Auth.auth().signIn(withEmail: createAccountEmail, password: createAccountPassword) { authResult, error in
                                    if let error = error {
                                        // Handle error if sign in failed
                                        print("Sign in failed: \(error.localizedDescription)")
                                    } else {
                                        // Sign in succeeded, navigate to the main screen
                                        navigateToMainScreen()
                                    }
                                }
                            }
                        }
                    }
                    .buttonStyle(FilledButtonStyle())
                    .padding(.top, 20)

                    Button("Cancel") {
                        showCreateAccountForm = false
                    }
                    .buttonStyle(FilledButtonStyle())
                    .padding(.top, 20)

                    Spacer()
                }
            }
        }
    }

    func navigateToMainScreen() {
        let contentView = RTabView(addInfo: UserAddition()) // Replace UserAddition with the name of your actual data model if applicable
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    @State private var window: UIWindow? // Add
    
    struct FilledButtonStyle: ButtonStyle {
        func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .padding(.horizontal, 50)
                .padding(.vertical, 10)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(5)
                .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
        }
    }
}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
