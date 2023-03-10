//
//  AddModel.swift
//  PPortal
//
//  Created by Marshall Jones on 3/2/23.
//

import Foundation
import Combine
import Firebase

//this is a type container i added to represent the different measurements, we can add and remove from this without breaking much
enum Units:Double{
    case oz = 1.0
    case floz = 1.25
    case cup = 1.50
    case lb = 1.75
    case gram = 2.00
    case kg = 2.25
    
    func formatted()->String  {
        var sizeString = ""
        switch self{
        case .oz:
            sizeString = "OZ"
        case .floz:
            sizeString = "FLOZ"
        case .cup:
            sizeString = "Cup"
        case .lb:
            sizeString = "LB"
        case .gram:
            sizeString = "Gram"
        case .kg:
            sizeString = "KiloG"
        }
        return sizeString
    }
}

//same thing/functionality as the previous
enum Types:Double{
    
    case prot = 1.00
    case veg = 1.25
    case grain = 1.50
    case fruit = 1.75
    case dairy = 2.00
    case misc = 2.25
    
    func formatted()->String{
        
        var typeString = ""
        switch self{
        case .prot:
            typeString = "Protein"
        case .veg:
            typeString = "Veggie"
        case .dairy:
            typeString = "Dairy"
        case .fruit:
            typeString = "Fruit"
        case .grain:
            typeString = "Grain"
        case .misc:
            typeString = "Misc."
            
        }
        return typeString
    }
    
}

//small class to facilitate the larger one,
class ingredientDrawer:ObservableObject{
    
    var id:Int = 0
    var thisType:String
    var typeString:String
    var ingr_Drawer:[Ingredient]
    
   
    
    //blank initializer
    init(){
        
        id = 0
        thisType = ".misc.formatted()"
        typeString = "NULL"
        ingr_Drawer = []
        
    }
    
    //parameterized initializer
    init(myID:Int, myType:Types, stringType:String){
        
        id = myID
        thisType = myType.formatted()
        typeString = stringType
        
        ingr_Drawer = []
        
        
    }
    
    
    
    //main function/reason i made this
    func addTo(ingr_add:Ingredient){
        
        self.ingr_Drawer.append(ingr_add)
        
    }
    
    
}

//this is the model that facilitates adding new ingredients to different types
class additionModel:ObservableObject{
    
    var id:Int = 0
    
    func newID()->Int{
        id+=1
        return id
    }
    
    //was easier to just declare each drawer like this to add
    @Published var userProt = ingredientDrawer(myID: 0, myType: .prot, stringType: "Protein")
    @Published var userVeggie = ingredientDrawer(myID: 1, myType: .veg, stringType: "Veggie")
    @Published var userGrain = ingredientDrawer(myID: 2, myType: .grain, stringType: "Grain")
    @Published var userDairy = ingredientDrawer(myID: 3, myType: .dairy, stringType: "Dairy")
    @Published var userFruit = ingredientDrawer(myID: 4, myType: .fruit, stringType: "Fruit")
    @Published var userMisc = ingredientDrawer(myID: 5, myType: .misc, stringType: "Misc.")
    
    
    
    
    
    init(){
        
        self.userProt = ingredientDrawer(myID: 0, myType: .prot, stringType: "Protein")
        self.userVeggie = ingredientDrawer(myID: 1,myType: .veg, stringType: "Veggie")
        self.userDairy = ingredientDrawer(myID: 2,myType: .dairy, stringType: "Dairy")
        self.userGrain = ingredientDrawer(myID: 3,myType: .grain, stringType: "Grain")
        self.userFruit = ingredientDrawer(myID: 4,myType: .fruit, stringType: "Fruit")
        self.userMisc = ingredientDrawer(myID: 5,myType: .misc, stringType: "Misc.")
        self.id = 0
        
        
    }
    
    
    //will take in a specific ingredients information and then add it to the representative type; main function
    func addToPantry(typeof:String, unitof:String, quantity:String, nameof:String){
        
        let tS:String = typeof
        
        let toAdd = Ingredient(id: newID(), name: nameof, amount: quantity, type: typeof)
        
        
        if(tS == "Protein"){
            userProt.addTo(ingr_add: toAdd)
        }
        else if(tS == "Veggie"){
            userVeggie.addTo(ingr_add: toAdd)
        }
        else if(tS == "Dairy"){
            userDairy.addTo(ingr_add: toAdd)
        }
        else if(tS == "Grain"){
            userGrain.addTo(ingr_add: toAdd)
        }
        else if(tS == "Fruit"){
            userFruit.addTo(ingr_add: toAdd)
        }
        else if(tS == "Misc."){
            userMisc.addTo(ingr_add: toAdd)
        }
        else{
            exit(EXIT_FAILURE)
        } // error case
        
    }
    
}

//this seems kind of arbitrary but its how im able to move information around within the views within losing it
class UserAddition:ObservableObject{
    
    @Published var unit:Units
    @Published var type:Types
    @Published var userIngredients:additionModel
    
    init() {
        self.unit = .cup
        self.type = .misc
        userIngredients = additionModel()
        
        fetchData()
    }
    
    func fetchData(){
        
        let db = Firestore.firestore()
        let ref = db.collection("pantry")
        
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let id = data["i_name"] as? String ?? ""
                    let type = data["type"] as? String ?? ""
                    let unit = data["unit"] as? String ?? ""
                    let amount = data["amount"] as? String ?? ""
                    
                    //want to make an array of ingredientDrawers
                    
                    self.userIngredients.addToPantry(typeof: type, unitof: unit, quantity: amount, nameof: id)
                    //all entries in the database will be apart of the Useraddition's userIngredient which is of type userAddition
                    //userAddition has a component called ingrDrawer which represents the types, however addtopantry handles the addition by type
                }
            }
        }
    }
    
}
