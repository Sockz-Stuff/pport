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
    
    init(){
        
        FirebaseApp.configure()
        
    }
    
    var body: some Scene {
        WindowGroup {
            RTabView(addInfo: UserAddition())
        }
    }
}
