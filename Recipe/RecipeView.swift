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
                Text("Recipes Ready To Make").font(.system(size: 28.0)).bold()
                    .bold()
                    .frame(width: 2000, height: 50)
                    .foregroundColor(.white)
                    .background(Color.red)
            }
           HStack{
               List (model.Recipes) { item in
                    Text(item.Name)
                       let _url = URL(string: item.Link)
                       Link("Link To Recipe", destination: _url!)
                        .bold()
                }
               
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

