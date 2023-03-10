//
//  RecipeView.swift
//  pport
//
//  Created by Diego Rivera on 3/9/23.
//

import SwiftUI
import Firebase

struct RecipeView: View {
    
    @ObservedObject private var model = DatabaseViewModel()
    
    
    var body: some View {
        VStack{
            HStack{
               List (model.Recipes) { item in
                    Text(item.Name)
                    
                    let _url = URL(string: item.Link)
                    Link("Link To Recipe", destination: _url!)
                    // self.model.getData()
                }
                Divider()
            }
        }
        
    }
        
    init() {
        model.getRecipes()
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

