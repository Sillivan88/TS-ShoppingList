//
//  CustomEditButton.swift
//  TS ShoppingList
//
//  Created by Trainer on 14.11.20.
//

import SwiftUI

struct CustomEditButton: View {
    @Environment(\.editMode) var editMode
    
    private var isEditing: Bool {
        editMode?.wrappedValue.isEditing ?? false
    }
    
    var body: some View {
        Button(action: {
            withAnimation {
                editMode?.wrappedValue = isEditing ? .inactive : .active
            }
        }, label: {
            Image(systemName: isEditing ? "pencil.circle.fill" : "pencil.circle")
                .resizable()
                .scaledToFit()
                .frame(height: 24)
        })
    }
}

struct CustomEditButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomEditButton()
    }
}
