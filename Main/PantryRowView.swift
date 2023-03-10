//
//  PantryRowView.swift
//  PPortal
//
//  Created by Marshall Jones on 2/15/23.
//

import SwiftUI

struct PantryRowView: View {
    var title: String
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment:.top,spacing:15){
                
               
                Image(systemName: "homekit")
                
                    
                Text(title)
                    
                
            }
        
            
        }
    }
}

struct PantryRowView_Previews: PreviewProvider {
    static var previews: some View {
        PantryRowView(title: "PlaceHolder")
    }
}
