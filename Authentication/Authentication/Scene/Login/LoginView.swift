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
        VStack {
            Group {
                TextField("E-posta", text: $viewModel.email)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                
                SecureField("Şifre", text: $viewModel.password)
            }
            .textFieldStyle(.roundedBorder)
            Button {
                Task {
                    await viewModel.tryLogin()
                    router.navigateHome()
                }
            } label: {
                Text("Giriş")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding()
            
            Button {
                router.navigateRegister()
            } label: {
                HStack(spacing: 5) {
                    Text("Hesabın yok mu?")
                        .foregroundColor(.gray)
                    Text("Hemen Kayıt Ol!")
                        .foregroundColor(.blue)
                }
                .font(.callout)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
         
            }
            .buttonStyle(.borderless)
        }
        .padding()
        .navigationTitle("Giriş")
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        ViewFactory().getLogin()
    }
}
