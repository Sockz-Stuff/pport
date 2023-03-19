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
        
        models.getRecipes()
        
        var matchingRecipe:[Recipe] = []
        
        //array of user ingredients (string name)

        var userI:[String] = []
        
        
        
        
        
        
        
        
//        var temp:[String] = []
    
        
        if(!addInfo.userIngredients.userFruit.ingr_Drawer.isEmpty){
//            temp = temp + userIngredients.userFruit.list()
            print("line 296")
            userI.append(contentsOf: addInfo.userIngredients.userFruit.list())
        }
        if(!addInfo.userIngredients.userMisc.ingr_Drawer.isEmpty){
//            temp = temp + userIngredients.userMisc.list()
            userI.append(contentsOf: addInfo.userIngredients.userMisc.list())
        }
//        if(!addInfo.userIngredients.userProt.ingr_Drawer.isEmpty){
//            temp = temp +  userIngredients.userProt.list()
        
        userI.append(contentsOf: addInfo.userIngredients.userProt.list())
//        }
        if(!addInfo.userIngredients.userGrain.ingr_Drawer.isEmpty){
//            temp += userIngredients.userGrain.list()
            userI.append(contentsOf: addInfo.userIngredients.userGrain.list())
        }
        if(!addInfo.userIngredients.userVeggie.ingr_Drawer.isEmpty){
//            temp += userIngredients.userVeggie.list()
            userI.append(contentsOf: addInfo.userIngredients.userVeggie.list())
        }
        if(!addInfo.userIngredients.userDairy.ingr_Drawer.isEmpty){
//            temp += userIngredients.userDairy.list()
            userI.append(contentsOf: addInfo.userIngredients.userDairy.list())
        }
        
        
        
        
        
        
        
        
        
        
        
        //array of recipe ingredients (string name)
        models.getRecipes()
        var recipeI:[String] = models.giveRecipeIngr()
        
        
        
        var matchingIngr:[String] = []
        
        for i in 0...(recipeI.count){
    
            for j in 0...(userI.count){
                
                    if(userI[j] == recipeI[i]){
                        matchingIngr.append(userI[j])
                    }
                
                
            }
            
        }
                
        for i in 0...(models.Recipes.count){
            //print(models.Recipes[i].Ingredients.count)
            for j in 0...(models.Recipes[i].Ingredients.count){
                for k in 0...matchingIngr.count{
                    if((models.Recipes[i].Ingredients[j]) == matchingIngr[k]){
                        matchingRecipe.append(models.Recipes[i])
                    }

                }
            }
        }
        
        return matchingRecipe
        
        
    }
    

    var body: some View {
        VStack{
            HStack{
                Text("Recipes Ready To Make").font(.system(size: 28.0)).bold()
                    .bold()
                    .frame(width: 2000, height: 50)
                    .foregroundColor(.black)
                    .background(.green)
            }
           HStack{
               List (userRecipe()) { item in
                    Text(item.Name)
                       let _url = URL(string: item.Link)
                       Link("Link To Recipe", destination: _url!)
                        .bold()
                }
               
        }
        }
    }
    
    init() {
        models.getRecipes()
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
        GeneratorView()
            .environmentObject(UserAddition())
    }
}

