//
//  LoginUseCase.swift
//  Authentication
//
//  Created by Salihcan Kahya on 2.10.2023.
//


public protocol LoginUseCaseProtocol {
    func execute(request: LoginRequest) async throws -> LoginResponse
}

public struct LoginUseCase: LoginUseCaseProtocol {
    private let repository: AuthenticationRepositoryProtocol
    
    public init(repository: AuthenticationRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(request: LoginRequest) async throws -> LoginResponse {
        let response = try await repository.tryLogin(request: .init(email: request.email, password: request.password))
        return .init(token: response.token)
    }
    
    func validateEmail() {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
    }
}
