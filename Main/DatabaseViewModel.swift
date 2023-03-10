//
//  DatabaseViewModel.swift
//  PPortal
//
//  Created by Diego Rivera on 2/24/23.
//

import Foundation
import Firebase

class DatabaseViewModel: ObservableObject {
    
    @Published var list = [Recipe]()
    func getData() {
    
    // Get a reference to the database
    let db = Firestore.firestore()
    
    // Read the documents at a specific path
    db.collection("Recipes").getDocuments { snapshot, error in
        
        if error == nil {
            
            if let snapshot = snapshot {
                // Update the list property in the main thread
                DispatchQueue.main.async {
                    self.list = snapshot.documents.map { d in
                        return Recipe(id: d.documentID,
                                    name: d["Name"] as? String ?? "",
                                      ingredients: (d["Ingredients"] as? Array<String>)! ,
                                      link: d["Link"] as? String ?? "")
                    }
                }
                
                
            }
        }
        else {
            // Handle the error
        }
    }
}

}
