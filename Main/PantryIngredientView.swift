//
//  PantryIngredientView.swift
//  PPortal
//
//  Created by Marshall Jones on 2/19/23.
//

import SwiftUI

struct PantryIngredientView: View {
    var specificType: Ingredient
    var body: some View {
        Text(specificType.name)
    }
}

struct PantryIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        PantryIngredientView(specificType: testI1)
    }
}
