//
//  ShopListView.swift
//  CryptoApp
//
//  Created by Kristina Korotkova on 09/04/23.
//

import SwiftUI

struct ShopListView: View {
    
    @ObservedObject private var viewModel: ShopListViewModel
    @State var isPresented = false
    
    let columns = [
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14)
    ]
    
    init(viewModel: ShopListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                shopListView
            }

            ZStack {
                NavigationBar(
                    title: "Shop List",
                    rightBarButton: .init(
                        imageName: "plus",
                        action: { isPresented.toggle() })
                )
            }
        }
        .background(Color.gray.opacity(0.1))
        .sheet(isPresented: $isPresented) {
            AccountView(isPresented: $isPresented)
        }
    }
    
    var shopListView: some View {
        VStack(alignment: .leading) {
            Spacer()
                .frame(height: 125)
            Text("Choose shop")
                .font(.custom("GTWalsheimPro-Medium", size: 20))
                .foregroundColor(Color.gray)
                .frame(alignment: .leading)
            LazyVGrid(columns: columns, spacing: 14) {
                ForEach(viewModel.models) { model in
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(height: 170)
                            .foregroundColor(.white)
                            .shadow(
                                color: .gray.opacity(0.03),
                                radius: 36, x: 0, y: 18
                            )
                        VStack(alignment: .leading) {
                            HStack {
                                Image(model.icon)
                                    .frame(width: 50, height: 50)
                                    .scaledToFit()
                                    .cornerRadius(25)
                                Spacer()
                            }
                            Spacer()
                            Text(model.title)
                                .font(.custom("GTWalsheimPro-Bold", size: 21))
                        }
                        .padding(20)
                    }
                }
            }
        }
        .padding()
        .ignoresSafeArea()
    }
}

struct ShopList_Previews: PreviewProvider {
    static var previews: some View {
        ShopListView(viewModel: ShopListViewModel())
    }
}
