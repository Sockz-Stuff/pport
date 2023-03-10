//
//  AddUIView.swift
//  PPortal
//
//  Created by nicole boie on 2/14/23.
//add and remove view

import SwiftUI
import Firebase

struct AddView: View {
    
    let measurements :[Units] = [.oz,.cup,.floz,.gram,.kg,.lb]
    let types :[Types] = [.prot, .veg, .dairy, .fruit, .grain, .misc]
    @EnvironmentObject var addInfo: UserAddition
    @State var comments:String=""
    @State var quantity:Int = 0
    @State var showingAlert = false
    //for error handling
    @State var didAdd:Bool = false
    @State var whatsWrong:String = ""
    
    func addIngr(){
        
        
        
//        ref.getDocuments { snapshot , error in
//            guard error == nil else{
//                print(error!.localizedDescription)
//                return
//            }
//            if let snapshot = snapshot{
//                for document in snapshot.documents{
//                    let data = document.data()
//                    let name = data["name"] as? String ?? ""
//                    let unit = data["unit"] as? Units ?? .oz
//                    let type = data["type"] as? Types ?? .prot
//                    let amount = data["amount"] as? Int ?? 0
//
//
//
//                }
//            }
//        }
        if(comments == ""){
            whatsWrong = "Missing Ingredient Name"
            showingAlert = true
            return
        }
        if(quantity == 0){
            whatsWrong = "Quantity Of Ingredient Cannot Be 0"
            showingAlert = true
            return
        }
        
        
        addInfo.userIngredients.addToPantry(typeof: addInfo.type.formatted(), unitof: addInfo.unit.formatted(), quantity: String(quantity), nameof: comments)
        whatsWrong = "Ingredient: " + comments + " added!"
        showingAlert = true
        
//        ref.setData(["breed": dogBreed, "id" : 10]) { error in
//            if let error = error {
//                print(error.localizedDescription)
//            }
//        }
        
        let db=Firestore.firestore()
        let ref=db.collection("pantry").document()
        
        
        
        ref.setData(["i_name": comments, "amount": quantity, "type": addInfo.type.formatted(), "unit": addInfo.unit.formatted()]){error in
            if let error = error{
                print(error.localizedDescription)
            }
        }
        
    }
    
    var body: some View {
        
        
        VStack{
    
            Spacer()
            
            TextField("Name of Ingredient here", text:$comments)
                .background(.white)
            Spacer()
            Picker(selection: $addInfo.unit, label: Text("Unit Type")){
                ForEach(measurements, id:\.self){unit in
                    Text(unit.formatted()).tag(unit)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            Picker(selection: $addInfo.type, label: Text("Unit Type")){
                ForEach(types, id:\.self){type in
                    Text(type.formatted()).tag(type)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            
            
            
            Spacer()
            Stepper(value: $quantity, in: 1...100){
                Text("Quantity: \(quantity)")
                    .bold()
            }
            
            Spacer()
            
            Button(action: addIngr) {
               Text("Add to Pantry")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                    .background(.black)
                .foregroundColor(.green)
                    .cornerRadius(5)
            }.alert(whatsWrong, isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            }
                
             
            
        }
        
        
    }
}

//marshall waz here

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView().environmentObject(UserAddition())
    }
}
