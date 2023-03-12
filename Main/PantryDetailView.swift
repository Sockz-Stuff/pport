//
//  PantryDetailView.swift
//  PPortal
//
//  Created by Marshall Jones on 2/15/23.
//

import SwiftUI

struct PantryDetailView: View {
    var currentIngrType: ingredientDrawer
    var IngrDetails = FirstIngrTypeModel().drawer
    @EnvironmentObject var addInfo: UserAddition
    var body: some View {
        
        VStack{
            HStack{
                Text(currentIngrType.thisType).font(.system(size: 28.0)).bold()
                    .bold()
                                .frame(width: 2000, height: 50)
                                .foregroundColor(.black)
                                .background(.green)
            }
            HStack(){
                
                NavigationView{
                    
                    List(currentIngrType.ingr_Drawer){ item in
                        NavigationLink(destination: PantryIngredientView(specificType: item).environmentObject(addInfo)){
                            PantryRowView(title: item.name)
                        }
                        
                    }
                    
                }
                
            }
            
        }
    }
}

struct PantryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        //change the way this recieved data for the ingredients
        PantryDetailView(currentIngrType: ingredientDrawer())
    }
}
