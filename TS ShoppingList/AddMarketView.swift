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
        let nameBinding = Binding<String>(get: {
            if self.newMarket.name != nil {
                return self.newMarket.name!
            }
            return ""
        }, set: {
            self.newMarket.name = $0
        })
        let notesBinding = Binding<String>(get: {
            if self.newMarket.notes != nil {
                return self.newMarket.notes!
            }
            return ""
        }, set: {
            self.newMarket.notes = $0
        })
        return Form {
            Section(header: Text("Name")) {
                TextField("Name", text: nameBinding)
            }
            Section(header: Text("Notes")) {
                TextEditor(text: notesBinding)
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
