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
    private let action: (LoginAction) -> Void
    
    public init(viewModel: LoginViewModel, action closure: @escaping (LoginAction) -> Void) {
        self.viewModel = viewModel
        self.action = closure
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
                }
            } label: {
                Text("Giriş")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .padding()
    }
    
}


struct ViewFactory {
    
    
    func getLogin() -> LoginView {
        
        let apiAdapter = MockApiAdapter()
        let repository = AuthenticationRepository(authRemote: apiAdapter)
        let loginUseCase = LoginUseCase(repository: repository)
        let viewModel = LoginViewModel(loginUseCase: loginUseCase)
        let view = LoginView(viewModel: viewModel, action: { _ in })
        
        return view
    }
    
    
    struct MockApiAdapter: AuthenticationRemoteAdapter {
        func login(request: LoginRequestDTO) async throws -> LoginResponseDTO {
            throw NSError(domain: "test", code: 1)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        ViewFactory().getLogin()
    }
}
