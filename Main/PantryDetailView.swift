//
//  PantryDetailView.swift
//  PPortal
//
//  Created by Marshall Jones on 2/15/23.
//

import SwiftUI

struct PantryDetailView: View {
    var currentIngrType: IngredientType
    var IngrDetails = FirstIngrTypeModel().drawer
    var body: some View {
        
        HStack(){
            
            NavigationView{
                // this navigation link takes me to the PantryIngredientView when i click on one of the bars
                // these bars are also PantryRowView but need to show the Ingredients of the displayed type
                List(currentIngrType.drawer){item in
                    NavigationLink(destination: PantryIngredientView(specificType: item)){
                        PantryRowView(title: item.name)
                    }
                }.navigationBarTitle(currentIngrType.type)
            }
            
            
            
        }
        
    }
}

struct PantryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PantryDetailView(currentIngrType: myMeatDrawer)
    }
}
