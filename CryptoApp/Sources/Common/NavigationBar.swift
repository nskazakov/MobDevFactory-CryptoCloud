//
//  NavigationBar.swift
//  CryptoApp
//
//  Created by Игорь Николаев on 16.04.2023.
//
import SwiftUI

struct NavigationBar: View {

    struct BarButtonType {
        let title: String?
        let imageName: String?
        let action: (() -> Void)?

        init(
            title: String? = nil,
            imageName: String? = nil,
            action: (() -> Void)?
        ) {
            self.title = title
            self.imageName = imageName
            self.action = action
        }
    }

    @State var title: String

    @State var leftBarButton: BarButtonType? = nil
    @State var rightBarButton: BarButtonType? = nil

    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .frame(height: 140)
                    .foregroundColor(.white)
                    .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
                    .shadow(
                        color: .gray.opacity(0.03),
                        radius: 36, x: 0, y: 18
                    )

                HStack {
                    if let leftBarButton {
                        Button {
                            leftBarButton.action?()
                        } label: {
                            if leftBarButton.title != nil {
                                // TODO: - add title button impl
                            } else if let imageName = leftBarButton.imageName {
                                Image(systemName: imageName)
                                    .font(.system(size: 24))
                                    .foregroundColor(Color.black)
                            }
                        }
                        .padding(.leading, 20)
                        .padding(.trailing, 10)
                        .padding(.top, 50)
                    }

                    HStack {
                        Text(title)
                            .font(.custom("GTWalsheimPro-Bold", size: 24))
                            .frame(alignment: .leading)
                        Spacer()
                    }
                    .padding(.leading, leftBarButton != nil ? 0 : 20)
                    .padding(.top, 50)

                    if let rightBarButton {
                        Button {
                            rightBarButton.action?()
                        } label: {
                            if rightBarButton.title != nil {
                                // TODO: - add title button impl
                            } else if let imageName = rightBarButton.imageName {
                                Image(systemName: imageName)
                                    .font(.system(size: 24))
                                    .foregroundColor(Color.blue)
                            }
                        }
                        .padding()
                        .padding(.top, 50)
                    }
                }
            }
            .ignoresSafeArea()
            Spacer()
        }
    }
}
