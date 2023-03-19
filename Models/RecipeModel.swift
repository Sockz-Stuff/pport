//
//  RecipeModel.swift
//  PPortal
//
//  Created by Diego Rivera on 2/24/23.
//

import Foundation
import Firebase

struct Recipe: Identifiable {
    var id: String
    var Name: String  //recipe name
    var Ingredients: [String]  //ingredients
    var Quantity: [Int]
    var Link: String //link to steps
}

