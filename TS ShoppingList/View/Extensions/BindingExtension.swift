//
//  BindingExtension.swift
//  TS ShoppingList
//
//  Created by Trainer on 14.11.20.
//

import SwiftUI

extension Binding {
    
    func toNonOptionalValue<T>(fallback: T) -> Binding<T> where Value == T? {
        Binding<T>(get: {
            wrappedValue ?? fallback
        }, set: {
            wrappedValue = $0
        })
    }
    
    func toNonOptionalString(fallback: String = "") -> Binding<String> where Value == String? {
        toNonOptionalValue(fallback: fallback)
    }
    
    func toNonOptionalDate(fallback: Date = Date()) -> Binding<Date> where Value == Date? {
        toNonOptionalValue(fallback: fallback)
    }
    
}
