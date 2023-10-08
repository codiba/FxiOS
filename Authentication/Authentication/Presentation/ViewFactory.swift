//
//  ViewFactory.swift
//  Authentication
//
//  Created by Salihcan Kahya on 3.10.2023.
//

import Foundation

struct ViewFactory {
    func getLogin() -> LoginView {
        
        let apiAdapter = MockApiAdapter()
        let repository = AuthenticationRepository(authRemote: apiAdapter)
        let loginUseCase = LoginUseCase(repository: repository)
        let viewModel = LoginViewModel(loginUseCase: loginUseCase)
        let view = LoginView(viewModel: viewModel, router: MockLoginRouter())
        
        return view
    }
    
    func getRegister() -> RegisterView {
        let apiAdapter = MockApiAdapter()
        let repository = AuthenticationRepository(authRemote: apiAdapter)
        let registerUseCase = RegisterUseCase(repository: repository)
        let viewModel = RegisterViewModel(registerUseCase: registerUseCase)
        let view = RegisterView(viewModel: viewModel, router: MockRegisterRouter())
        return view
    }
    
    struct MockApiAdapter: AuthenticationRemoteAdapter {
        func register(request: RegisterRequestDTO) async throws -> RegisterResponseDTO {
            throw NSError(domain: "test", code: 1)
        }
        
        func login(request: LoginRequestDTO) async throws -> LoginResponseDTO {
            throw NSError(domain: "test", code: 1)
        }
    }
}
