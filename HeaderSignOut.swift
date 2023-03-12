//
//  HeaderSignOut.swift
//  pport
//
//  Created by nicole boie on 3/11/23.
//

import SwiftUI
import Firebase
struct HeaderSignOut: View {
    @State var navigated = false
    @State public var userIsLoggedIn: Bool=false
    func setup(){
        
        userIsLoggedIn=false
        
    }
    var body: some View {
        
        
        NavigationLink(destination: Login().environmentObject(UserAddition())) {
            Button {
                setup()
                out()
            } label: {
                Text("Sign out")
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
            
        }
    }
    func out(){
        do
        {
            
            try Auth.auth().signOut()
            
        }
        catch let error as NSError
        {
            print (error.localizedDescription)
        }
    }
}

struct HeaderSignOut_Previews: PreviewProvider {
    @State static var userIsLoggedIn=false
    static var previews: some View {
        HeaderSignOut(userIsLoggedIn: userIsLoggedIn)
       // HeaderSignOut(userIsLoggedIn: userIsLoggedIn)
        //Login().environmentObject(UserAddition())
    }
}
