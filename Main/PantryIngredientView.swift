//
//  PantryIngredientView.swift
//  PPortal
//
//  Created by Marshall Jones on 2/19/23.
//

import SwiftUI
import Firebase

struct Contented2: View {
    @EnvironmentObject var viewModel: AppViewModel
    @EnvironmentObject var addInfo: UserAddition
    
    var body: some View {
        NavigationView {
            if viewModel.deleteed {
                
                RTabView(addInfo:UserAddition())
            }
            else {
                
            }
        }
        .onAppear {
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
    
}

struct PantryIngredientView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State var showView = false
    var specificType: Ingredient
    @State var showingAlert = false
    @State var deletedIt:String = ""
   
    @EnvironmentObject var addInfo: UserAddition
    
    
    func delete(todelete: Ingredient){
        
        let db=Firestore.firestore()
        let ref=db.collection("pantry")
        
        ref.document(todelete.id).delete()
        //viewModel.deleteed = true
        
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
            Text("Amount: "+String(specificType.amount)+" "+specificType.unit)
            Text(specificType.type)
            
        
        
            Button(action: setup){
                Text("Delete Ingredient")
                    .font(.title)
                    .fontWeight(.medium)
                    .padding()
                    .background(.green)
                    .foregroundColor(.black)
                    .cornerRadius(5)
            }
        }.alert(deletedIt, isPresented: $showingAlert) {
            Button("OK", role: .cancel) {deleteed()}
            }
        
    }
    func deleteed() {
        let contentView = RTabView(addInfo: UserAddition())
   
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    @State private var window: UIWindow?
}

struct PantryIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        PantryIngredientView(specificType: testI1)
    }
}
