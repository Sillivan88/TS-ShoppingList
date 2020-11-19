//
//  AddMarketView.swift
//  TS ShoppingList
//
//  Created by Trainer on 14.11.20.
//

import SwiftUI

struct AddMarketView: View {
    @StateObject private var newMarket = Market(context: PersistenceController.shared.managedObjectContext)
    
    var body: some View {
        Form {
            Section(header: Text("Name")) {
                TextField("Name", text: Binding<String>.convertOptionalString($newMarket.name))
            }
            Section(header: Text("Notes")) {
                TextEditor(text: Binding<String>.convertOptionalString($newMarket.notes))
                    .frame(height: 300)
            }
        }
    }
}

struct AddMarketView_Previews: PreviewProvider {
    static var previews: some View {
        AddMarketView()
    }
}
