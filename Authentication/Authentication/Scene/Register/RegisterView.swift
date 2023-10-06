//
//  RegisterView.swift
//  Authentication
//
//  Created by Salihcan Kahya on 3.10.2023.
//

import SwiftUI

public struct RegisterView: View {
    @ObservedObject private var viewModel: RegisterViewModel
    private let router: RegisterRouterProtocol
    
    public init(viewModel: RegisterViewModel, router: RegisterRouterProtocol) {
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
                viewModel.tryRegister()
            } label: {
                Text("Kayıt Ol")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .padding()
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        ViewFactory().getRegister()
    }
}
