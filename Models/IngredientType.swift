//
//  IngredientType.swift
//  PPortal
//
//  Created by Marshall Jones on 2/15/23.
//

import Foundation

//examples of ingredient types are meats, vegies, fruits, etc

struct IngredientType:Identifiable{
    
    var id: Int
    var type: String
    var drawer: Array<Ingredient>
    
}

let TestIngredientModel1 = Ingredient(id: "1", name: "Steak", amount: "4", type: "Meat")
let TestIngredientModel2 = Ingredient(id: "2", name: "Chicken", amount: "13", type: "Meat")
let TestIngredientModel3 = Ingredient(id: "3", name: "Ground Beef", amount: "2", type: "Meat")
let TestIngredientModel4 = Ingredient(id: "4", name: "Fish", amount: "6", type: "Meat")

//how you initialize an array, its pretty smart so it autos most of it for you
let myDrawer = [TestIngredientModel1, TestIngredientModel2, TestIngredientModel3, TestIngredientModel4]

//myDrawer.append(_newElement) to add

let testIngredientType = IngredientType(id: 1, type: "Meat", drawer: myDrawer)

struct FirstIngrTypeModel{
    
    var drawer:[Ingredient] = [
    
        TestIngredientModel1, TestIngredientModel2, TestIngredientModel3, TestIngredientModel4
        
    ]
    
}
