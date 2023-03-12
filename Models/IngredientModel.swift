//
//  IngredientModel.swift
//  PPortal
//
//  Created by Marshall Jones on 2/15/23.
//

import Foundation


struct Ingredient:Identifiable{
    var id: String
    var name:String
    var amount:String
    var type:String
}


let TestIngredientModel = Ingredient(id: "1", name: "Steak", amount: "4", type: "meat")
