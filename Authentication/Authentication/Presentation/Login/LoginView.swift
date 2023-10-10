//
//  LoginView.swift
//  Authentication
//
//  Created by Salihcan Kahya on 2.10.2023.
//

import SwiftUI

public enum LoginAction {
    case goToRegister
    case loginSuccess
}

public struct LoginView: View {
    
    @ObservedObject private var viewModel: LoginViewModel
    private let router: LoginRouterProtocol
    
    public init(viewModel: LoginViewModel, router: LoginRouterProtocol) {
        self.viewModel = viewModel
        self.router = router
    }
    
    public var body: some View {
        VStack(spacing: 15) {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(.blue)
                .padding(.bottom, 30)
            
            TextField("E-posta", text: $viewModel.email)
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)

            SecureField("Şifre", text: $viewModel.password)
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.none)

            HStack {
                Spacer()
                Button(action: {
                }) {
                    Text("Şifremi unuttum")
                        .foregroundColor(.gray)
                        .underline()
                        .font(.caption)
                }
                .padding(.top, 5)
            }
            .padding(.horizontal, 20)
            
            VStack {
                Button(action: {
                    viewModel.tryLogin()
                }) {
                    Text("Giriş Yap")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.7))
                        .cornerRadius(10)
                }
                .padding(.top, 20)
                
                HStack {
                    Button(action: {
                        viewModel.signInWithGoogle()
                    }) {
                       Image(systemName: "folder.circle")
                            .resizable()
                            .background(.white)
                            .frame(width: 45, height: 45)
                            .clipShape(RoundedRectangle(cornerRadius: 13))
                    }
                    .padding(.top, 20)
                }
            }
            
            Button(action: {
                router.navigateRegister()
            }) {
                HStack(spacing: 0) {
                    Text("Henüz hesabın yok mu?")
                        .foregroundColor(.gray)
                    Text(" Kayıt Ol!")
                    Spacer()
                }
                
            }
            .padding(.top, 10)
            .padding(.bottom, 40)
        }
        .cornerRadius(15)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 15)
        .onChange(of: viewModel.loginSuccess, perform: { newValue in
            guard newValue else { return }
            router.navigateHome()
        })
        .onChange(of: viewModel.loginError, perform: { newValue in
            guard let error = newValue else { return }
            print(error)
        })
    }
}


#Preview {
    ViewFactory().getLogin()
}
