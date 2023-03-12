//
//  Login.swift
//  pport
//
//  Created by nicole boie on 3/10/23.
//
import SwiftUI
import FirebaseAuth

class AppViewModel: ObservableObject {
    @EnvironmentObject var addInfo: UserAddition
    let auth = Auth.auth()
    @Published var deleteed = false
    @Published var signedIn = false

    var isSignedIn: Bool {
        return auth.currentUser != nil
    }

    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email,
                    password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }

            DispatchQueue.main.async {
                // Success
                self?.signedIn = true
            }
        }
    }

    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }

            DispatchQueue.main.async {
                // Success
                self?.signedIn = true
            }
        }
    }

    func signOut() {
        try? auth.signOut()

        self.signedIn = false
    }
}


struct Contented: View {
    @EnvironmentObject var viewModel: AppViewModel
    @EnvironmentObject var addInfo: UserAddition
    var body: some View {
        NavigationView {
            if viewModel.signedIn {
                
                RTabView(addInfo:UserAddition())
            }
            else {
                SignInView()
            }
        }
        .onAppear {
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
    
}

struct SignInView: View {
    @State var email = ""
    @State var password = ""

    @EnvironmentObject var viewModel: AppViewModel

    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)

            VStack {
                TextField("Email Address", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))

                SecureField("Password", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))

                Button(action: {

                    guard !email.isEmpty, !password.isEmpty else {
                        return
                    }

                    viewModel.signIn(email: email, password: password)

                }, label: {
                    Text("Sign In")
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .cornerRadius(8)
                        .background(Color.blue)
                })

                NavigationLink("Create Account", destination: SignUpView())
                    .padding()
            }
            .padding()


            Spacer()
        }
        .navigationTitle("Sign In")

    }
}

struct SignUpView: View {
    @State var email = ""
    @State var password = ""

    @EnvironmentObject var viewModel: AppViewModel

    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)

            VStack {
                TextField("Email Address", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))

                SecureField("Password", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))

                Button(action: {

                    guard !email.isEmpty, !password.isEmpty else {
                        return
                    }

                    viewModel.signUp(email: email, password: password)

                }, label: {
                    Text("Create Account")
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .cornerRadius(8)
                        .background(Color.blue)
                })
            }
            .padding()


            Spacer()
        }
        .navigationTitle("Create Account")

    }
}

struct Contented_Previews: PreviewProvider {
    static var previews: some View {
        Contented()
            .preferredColorScheme(.dark)
    }
}

/*import SwiftUI
import Firebase

struct Login: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var addInfo: UserAddition
    @State private var userIsLoggedIn = false
    
    var body: some View {
        
            if userIsLoggedIn {
                RTabView(addInfo: UserAddition())
            } else {
                content
            }
        }
    var content: some View {
        ZStack {
                    Color.brown
                    
                    
                    VStack(spacing: 20) {
                        Text("Welcome")
                            .foregroundColor(.green)
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                            .offset(x: -100, y: -100)
                        
                        TextField("Email", text: $email)
                            .foregroundColor(.white)
                            .textFieldStyle(.plain)
                            .placeholder(when: email.isEmpty) {
                                Text("Email")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                        
                        Rectangle()
                            .frame(width: 350, height: 1)
                            .foregroundColor(.white)
                        
                        SecureField("Password", text: $password)
                            .foregroundColor(.white)
                            .textFieldStyle(.plain)
                            .placeholder(when: password.isEmpty) {
                                Text("Password")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                        
                        Rectangle()
                            .frame(width: 350, height: 1)
                            .foregroundColor(.white)
                        
                        Button {
                            register()
                        } label: {
                            Text("Sign up")
                                .bold()
                                .frame(width: 200, height: 40)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(.green)
                                )
                                .foregroundColor(.white)
                        }
                        .padding(.top)
                        .offset(y: 100)
                        
                        Button {
                            login()
                        } label: {
                            Text("Already have an account? Login")
                                .bold()
                                .foregroundColor(.white)
                        }
                        .padding(.top)
                        .offset(y: 110)
                        
                    }
                    .frame(width: 350)
                    .onAppear {
                        Auth.auth().addStateDidChangeListener { auth, user in
                            if user != nil {
                                userIsLoggedIn
                                .toggle()
                                //need this to be signed in, will add back when sing out is implemented
                            }
                           
                        }
                    }
                }
                .ignoresSafeArea()
        
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }


    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
        
}


struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login().environmentObject(UserAddition())
    }
    

}
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
*/
