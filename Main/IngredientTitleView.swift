//
//  IngredientTitleView.swift
//  PPortal
//
//  Created by Marshall Jones on 2/15/23.
//

import SwiftUI

struct IngredientTitleView: View {
    var title:String
    var isDisplayingOrder:Bool! = nil
    var body: some View {
        HStack {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.leading)
            Spacer()

        }.overlay(
            Image(systemName:isDisplayingOrder ?? false ? "chevron.up.square" : "chevron.down.square")
                .font(.title)
                .foregroundColor(isDisplayingOrder != nil ? .black : .clear)
            .padding()
            ,alignment: .leading
        )
        .foregroundColor(.black)
        .background(.white)
    }
}

struct IngredientTitleView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientTitleView(title: "Try")
    }
}
