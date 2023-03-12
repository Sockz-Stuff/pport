//
//  LogoutView.swift
//  pport
//
//  Created by Marshall Jones on 3/12/23.
//

import SwiftUI

struct LogoutView: View {
    
    @EnvironmentObject var viewModel: AppViewModel

    
    var body: some View {
        Button(action: {
            viewModel.signOut()
 
        }, label: {
            Text("Sign Out")
                .frame(width: 200, height: 50)
                .background(Color.green)
                .foregroundColor(Color.blue)
                .padding()
        })
    }
}

struct LogoutView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutView()
    }
}
