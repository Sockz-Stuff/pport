//
//  DatabaseViewModel.swift
//  PPortal
//
//  Created by Diego Rivera on 2/24/23.
//

import Foundation
import Firebase

class DatabaseViewModel: ObservableObject {
    
    
    
    @Published var Recipes:[Recipe]
    private var db = Firestore.firestore()
    
    init(){
        
        Recipes = []
        
    }
    
    func getRecipes() {
    
    // Get a reference to the database
    db.collection("Recipes").getDocuments { snapshot, error in
                    
    // Check for errors
    if error == nil {
    // No errors
                        
    if let snapshot = snapshot {
                            
    // Update the list property in the main thread
        DispatchQueue.main.async {
                                
    // Get all the documents and create Todos
            self.Recipes = snapshot.documents.map { doc in
    // Create a Todo item for each document returned
                return Recipe(id: doc.documentID,
                Name: doc["name"] as? String ?? "",
                Ingredients: doc["ingredients"] as! [String],
                Quantity: doc["quantity"] as! [Int],
                Link: doc["link"] as? String ?? "")
                            }
                }
                            
                            
            }
        }
        else {
                        // Handle the error
        }
    }
           
}

    func giveRecipeIngr()->[String]{
        
        getRecipes()
        
        var temp:[String] = []
        
        
//        if(Recipes.isEmpty){
//            exit(EXIT_FAILURE)
//
//        }
        
        
        for i in 0...(Recipes.count-1){
           
            
                //print(Recipes[i].Ingredients.count)
                for j in 0...(Recipes[i].Ingredients.count-1){
                    print(j)
                    temp.append(Recipes[i].Ingredients[j])
                }
            
            
        }
        
        
        return temp
        
    }
    
}

