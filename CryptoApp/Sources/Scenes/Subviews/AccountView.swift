//
//  AccountView.swift
//  CryptoApp
//
//  Created by Игорь Николаев on 16.04.2023.
//

import SwiftUI

struct AccountView: View {

    @ObservedObject var viewModel: ShopViewModel

    @Binding var isPresented: Bool

    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    Button {
                    } label: {
                        ZStack {
                            Image("bank")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                            Image(systemName: "plus")
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundColor(.black)
                                .background(Color.white)
                                .cornerRadius(100)
                                .shadow(radius: 12)
                                .offset(x: 45, y: -35)
                        }
                        .frame(width: 100, height: 80)
                    }
                    .padding(20)

                    AccountStack(
                        title: "Account name",
                        textAccount: $viewModel.accountName,
                        placeholder: "Account name here"
                    )

                    HStack {
                        AccountStack(
                            title: "Add API Key",
                            textAccount: $viewModel.apiKey,
                            placeholder: "Add API Key here"
                        )

                        Button {
                            viewModel.createShop()
                            isPresented.toggle()
                        } label: {
                            Image(systemName: "chevron.right")
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 48, height: 48)
                                .bold()
                                .foregroundColor(.white)
                                .background(
                                    !viewModel.saveIsEnabled ? Colors.gray : Colors.pink
                                )
                                .cornerRadius(15)
                        }
                        .disabled(!viewModel.saveIsEnabled)
                        .padding(20)
                    }

                    Spacer()
                }
                .padding(.top, 140)
            }
            NavigationBar(
                title: "Shop List",
                leftBarButton: .init(
                    imageName: "plus",
                    action: { isPresented.toggle() })

            )
        }
        .background(Color.gray.opacity(0.1))
    }
}
