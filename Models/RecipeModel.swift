//
//  RecipeModel.swift
//  PPortal
//
//  Created by Diego Rivera on 2/24/23.
//

import Foundation

struct Recipe: Identifiable {
    var id: String
    var name: String  //recipe name
    var ingredients: Array<String>  //ingredients
    var link: String //link to steps
}
