//
//  pportApp.swift
//  pport
//
//  Created by Marshall Jones on 3/9/23.
//

//import SwiftUI
//import Firebase
//
//@main
//struct pportApp: App {
//
//    init(){
//
//        FirebaseApp.configure()
//
//    }
//
//    var body: some Scene {
//        WindowGroup {
//            RTabView(addInfo: UserAddition())
//        }
//    }
//}
import SwiftUI
import Firebase

@main
struct SwiftUIFirebaseAuthApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            //let viewModel = AppViewModel()
           // Contented()
             //   .environmentObject(viewModel)
            LoginView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        FirebaseApp.configure()

        return true
    }
}
