//
//  PantryIngredientView.swift
//  PPortal
//
//  Created by Marshall Jones on 2/19/23.
//

import SwiftUI
import Firebase

struct PantryIngredientView: View {
    @State var showView = false
    var specificType: Ingredient
    @State var showingAlert = false
    @State var deletedIt:String = ""
    @EnvironmentObject var addInfo: UserAddition
    
    
    func delete(todelete: Ingredient){
        
        let db=Firestore.firestore()
        let ref=db.collection("pantry")
        
        ref.document(todelete.id).delete()
        
    }
    
    func setup(){
        
        deletedIt = specificType.name+" was deleted!"
        showingAlert = true
        delete(todelete: specificType)
        addInfo.fetchData()
        
    }
    
    var body: some View {
        VStack{
            Text(specificType.name)
            Text("Amount: "+String(specificType.amount))
            Text(specificType.type)
            
        
        
            Button(action: setup){
                Text("Delete Ingredient")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                    .background(.brown)
                    .foregroundColor(.green)
                    .cornerRadius(5)
            }
        }.alert(deletedIt, isPresented: $showingAlert) {
            Button("OK", role: .cancel) {}
            }
    }
}

struct PantryIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        PantryIngredientView(specificType: testI1)
    }
}
