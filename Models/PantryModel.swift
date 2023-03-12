//
//  PantryModel.swift
//  PPortal
//
//  Created by Marshall Jones on 2/19/23.
//

import Foundation


struct Pantry:Identifiable{
    var id: Int
    var shelf: Array<IngredientType>
}

let testI1 = Ingredient(id: "1", name: "Steak", amount: "4", type: "Meat")
let testI2 = Ingredient(id: "2", name: "Milk", amount: "2", type: "Dairy")
let testI3 = Ingredient(id: "3", name: "Romain", amount: "13", type: "Vegetable")
let testI4 = Ingredient(id: "4", name: "Chicken", amount: "3", type: "Meat")
let testI5 = Ingredient(id: "5", name: "Swiss Cheese", amount: "2", type: "Dairy")
let testI6 = Ingredient(id: "6", name: "Turnip", amount: "7", type: "Vegetable")

let meats = [testI1, testI4]
let veggies = [testI3, testI6]
let dairies = [testI2, testI5]

let myMeatDrawer = IngredientType(id: 1, type: "Meat", drawer: meats)
let myDairyDrawer = IngredientType(id: 2, type: "Dairy", drawer: dairies)
let myVegDrawer = IngredientType(id: 3, type: "Vegetable", drawer: veggies)

let shelves = [myMeatDrawer, myVegDrawer, myDairyDrawer]

let myTestPantry = Pantry(id: 1, shelf: shelves)

struct FirstPantryModel{
    var pantry:[IngredientType] = [
        myMeatDrawer, myDairyDrawer, myVegDrawer
    ]
}

