//
//  GeneratorView.swift
//  pport
//
//  Created by Marshall Jones on 3/12/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct GeneratorView: View {
    //@StateObject var recipes = GeneratorModel()
    //@EnvironmentObject var viewModel: AppViewModel
    @EnvironmentObject var addInfo: UserAddition
    @ObservedObject var models = DatabaseViewModel()
    @State var uNames: [String] = []
    @State var uAmounts: [String] = []
  
    
    func userRecipe()->[Recipe]{
        
        var matchingRecipe:[Recipe] = []
        
        //array of user ingredients (string name)
        let userI = addInfo.giveIngredients()
        
        //array of recipe ingredients (string name)
        models.getRecipes()
        let recipeI = models.giveRecipeIngr()
        
        var matchingIngr:[String] = []
        
        for i in 0...recipeI.count{
            
            for j in 0...userI.count{
                
                if(userI[j] == recipeI[i]){
                    matchingIngr.append(userI[j])
                }
                
            }
            
        }
                
        for i in 0...models.Recipes.count{
            for j in 0...models.Recipes[i].Ingredients.count{
                for k in 0...matchingIngr.count{
                    if(models.Recipes[i].Ingredients[j] == matchingIngr[k]){
                        matchingRecipe.append(models.Recipes[i])
                    }

                }
            }
        }
        
        return matchingRecipe
        
        
    }
    

    var body: some View {
        VStack(){
            HStack{
                
            }
        }
        .onAppear(perform: {fetchRecipes()
            (self.uNames, self.uAmounts) = createUserArray(userMod: self.addInfo.userIngredients, userNames: &self.uNames, userAmounts: &self.uAmounts)
        }
        )
    }
    
    func createUserArray(userMod: additionModel, userNames: inout [String], userAmounts: inout [String]) -> ([String], [String]) {
        if !userMod.userDairy.ingr_Drawer.isEmpty {
            for useriterator in userMod.userDairy.ingr_Drawer {
                userNames.append(useriterator.name)
                userAmounts.append(useriterator.amount)
            }
        }
        if !userMod.userProt.ingr_Drawer.isEmpty {
            for useriterator in userMod.userProt.ingr_Drawer{
                userNames.append(useriterator.name)
                userAmounts.append(useriterator.amount)
            }
        }
        if !userMod.userGrain.ingr_Drawer.isEmpty {
            for useriterator in userMod.userGrain.ingr_Drawer {
                userNames.append(useriterator.name)
                userAmounts.append(useriterator.amount)
            }
        }
        if !userMod.userFruit.ingr_Drawer.isEmpty {
            for useriterator in userMod.userFruit.ingr_Drawer{
                userNames.append(useriterator.name)
                userAmounts.append(useriterator.amount)
            }
        }
        if !userMod.userVeggie.ingr_Drawer.isEmpty {
            for useriterator in userMod.userVeggie.ingr_Drawer {
                userNames.append(useriterator.name)
                userAmounts.append(useriterator.amount)
            }
        }
        if !userMod.userMisc.ingr_Drawer.isEmpty {
            for useriterator in userMod.userMisc.ingr_Drawer{
                userNames.append(useriterator.name)
                userAmounts.append(useriterator.amount)
            }
        }
        return (userNames, userAmounts)
    }
    
    func fetchRecipes() {
        //recipes.findRecipes(usermodel: addInfo, model: models)
        self.addInfo.fetchData()
        models.getRecipes()
    }
}

struct GeneratorView_Previews: PreviewProvider {
    static var previews: some View {
        GeneratorView(uNames: [], uAmounts: [])
            .environmentObject(UserAddition())
    }
}

