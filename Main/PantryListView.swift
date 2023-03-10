//
//  PantryListView.swift
//  PPortal
//
//  Created by Marshall Jones on 2/15/23.
//


// TODO
    //change Pantry row view to take in an ingredientType stub and display its title information and correct image
    //need to add an Ingredient type row view after that that takes in an ingredient and then displays all the information

import SwiftUI



//shows a stub for each ingredient type
struct PantryListView: View {
    //@ObservedObject var pantryScheme:
    @EnvironmentObject var addInfo: UserAddition
    var pantryList = FirstPantryModel().pantry
    
    struct u_types: Identifiable, Hashable {
        let name: String
        let id = UUID()
    }
    
    var categories = [
        u_types(name: "Protein"),
        u_types(name: "Veggie"),
        u_types(name: "Fruit"),
        u_types(name: "Dairy"),
        u_types(name: "Grain"),
        u_types(name: "Misc.")
    
    ]
    
    @State var selection = Set<UUID>()
    
    
    func setup(){
        
        addInfo.fetchData()
    }
    
    var body: some View {
        
        
        
        //RtabView -> PantryListView -> PantryIngredientView
        
        // all of these display their rows using PantryRowView
        
        //navigation link takes me to that spot when i click on one of the items
        // Currently the link takes me to the PantryDetailView, which has paramters of IngredientType
        // Pantry Row view is the thing thats specifically shown on each stub
        
       //test addition
            //Image("Pbackground")
            VStack(){
                NavigationView{
                    List(pantryList){item in
                        NavigationLink(destination: PantryDetailView(currentIngrType: item)){
                            PantryRowView(title: item.type)
                        }
                    }.navigationBarTitle("My Pantry")
                       
                }
            
                NavigationView{
                    List(categories, selection: $selection){ item in
                        NavigationLink(destination: PantryDetailView(currentIngrType: IngredientType))
                        
                    
                    }.navigationBarTitle("My Pantry")
                       
                }
                
                Button(action: setup){
                    Text("Load Pantry")
                         .font(.title)
                         .fontWeight(.bold)
                         .padding()
                         .background(.black)
                     .foregroundColor(.green)
                         .cornerRadius(5)
                 }
                
            }
        
    }
        
}

struct PantryListView_Previews: PreviewProvider {
    static var previews: some View {
        PantryListView().environmentObject(UserAddition())
    }
}
