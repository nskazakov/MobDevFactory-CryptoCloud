//
//  View+Extension.swift
//  CryptoApp
//
//  Created by Игорь Николаев on 16.04.2023.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
