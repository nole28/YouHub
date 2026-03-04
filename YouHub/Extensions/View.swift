//
//  View.swift
//  YouHub
//
//  Created by Novak Velimirovic on 2.3.26..
//

import SwiftUI

extension View {
    /// Applies a card-like style with padding, rounded corners, and shadow.
    func cardStyle() -> some View {
        self.padding()
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            .shadow(radius: 4)
    }
}
