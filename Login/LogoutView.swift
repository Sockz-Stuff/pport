//
//  LogoutView.swift
//  pport
//
//  Created by Marshall Jones on 3/12/23.
//

import SwiftUI
import FirebaseAuth
struct LogoutView: View {
    
    @EnvironmentObject var viewModel: AppViewModel

    
    var body: some View {
        
        Button(action: {
            navigateToLogin()
        }, label: {
            Text("Sign Out")
                .frame(width: 200, height: 50)
                .background(Color.green)
                .foregroundColor(.black)
                .padding()
        })
    }
    
    func signOut() {
        try? Auth.auth().signOut()

       
    }
    func navigateToLogin() {
        signOut()
        let contentView = LoginView()// Replace UserAddition with the name of your actual data model if applicable
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    @State private var window: UIWindow? // Add
    
}

struct LogoutView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutView()
    }
}
