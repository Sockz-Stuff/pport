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
    @EnvironmentObject var viewModel: AppViewModel
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

            VStack(){
                HStack{
                    Text("My Pantry").font(.system(size: 28.0)).bold()
                        .bold()
                        .frame(width: 2000, height: 50)
                        .foregroundColor(.black)
                        .background(.green)
                }
                NavigationStack {
                    List {
                        NavigationLink("Protein"){ PantryDetailView(currentIngrType: addInfo.userIngredients.giveDrawer(tS: "Protein")).environmentObject(addInfo)}
                        NavigationLink("Veggie"){ PantryDetailView(currentIngrType: addInfo.userIngredients.giveDrawer(tS: "Veggie")).environmentObject(addInfo)}
                        NavigationLink("Fruit"){ PantryDetailView(currentIngrType: addInfo.userIngredients.giveDrawer(tS: "Fruit")).environmentObject(addInfo)}
                        NavigationLink("Dairy"){ PantryDetailView(currentIngrType: addInfo.userIngredients.giveDrawer(tS: "Dairy")).environmentObject(addInfo)}
                        NavigationLink("Grain"){ PantryDetailView(currentIngrType: addInfo.userIngredients.giveDrawer(tS: "Grain")).environmentObject(addInfo)}
                        NavigationLink("Misc."){ PantryDetailView(currentIngrType: addInfo.userIngredients.giveDrawer(tS: "Misc.")).environmentObject(addInfo)}
                        
                    }
                    
                }
                
                Button(action: setup){
                    Text("Load Pantry")
                         .font(.title)
                         .fontWeight(.medium)
                         .padding()
                         .background(.green)
                     .foregroundColor(.black)
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
