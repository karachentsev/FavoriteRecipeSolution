//
//  ViewErrorAlert.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 22.09.2025.
//

import SwiftUI

extension View {
    func errorAlert(_ error: Binding<FRLib.CustomError?>, buttonTitle: String = "OK") -> some View {
        return alert(isPresented: .constant(error.wrappedValue != nil), error: error.wrappedValue) { _ in
            Button(buttonTitle) {
                error.wrappedValue = nil
            }
        } message: {
            Text($0.recoverySuggestion ?? "")
        }
    }
}
