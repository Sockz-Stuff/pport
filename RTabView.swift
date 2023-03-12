//
//  TabView.swift
//  PPortal
//
//  Created by nicole boie on 2/14/23.
//

import SwiftUI
import UIKit


struct RTabView: View {
    
   var addInfo: UserAddition
    
    var body: some View {
        TabView{
            
            
            PantryListView().environmentObject(addInfo)
                .tabItem{
                    Image(systemName: "house")
                    Text("Home")
                }
            AddView().environmentObject(addInfo)
                .tabItem{
                    Image(systemName: "plus")
                    Text("Add/Remove")
                }/*}
            RecipeView()
                .tabItem{
                Image(systemName: "book")
                    Text("Recipes")
                }
                  */
            
        }
    }
}

struct RTabView_Previews: PreviewProvider {
    static var previews: some View {
        RTabView(addInfo: UserAddition())
    }
}
