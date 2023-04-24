//
//  AccountStack.swift
//  CryptoApp
//
//  Created by Игорь Николаев on 16.04.2023.
//

import SwiftUI

struct AccountStack: View {

    @State var title: String
    @Binding var textAccount: String
    @State var placeholder: String

    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.custom("GTWalsheimPro-Regular", size: 12))
                    .foregroundColor(.secondary)
                Spacer()
            }
            TextField(placeholder, text: $textAccount)
                .lineLimit(1)
                .font(.custom("GTWalsheimPro-Bold", size: 20))
                .foregroundColor(.black)
            Divider()
                .foregroundColor(Color(.systemGray6))
        }
        .padding(20)
    }
}
