//
//  pportApp.swift
//  pport
//
//  Created by Marshall Jones on 3/9/23.
//

import SwiftUI
import Firebase

@main
struct pportApp: App {
   // @EnvironmentObject var addInfo: UserAddition
    init(){
        
        FirebaseApp.configure()
        
    }
    
    var body: some Scene {
        WindowGroup {
            Login().environmentObject(UserAddition())
        }
    }
}
