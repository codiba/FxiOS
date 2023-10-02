//
//  RegisterUseCase.swift
//  Authentication
//
//  Created by Salihcan Kahya on 3.10.2023.
//

public protocol RegisterUseCaseProtocol {
    func execute(request: RegisterRequest) async throws -> RegisterResponse
}

public struct RegisterUseCase: RegisterUseCaseProtocol {
    private let repository: AuthenticationRepositoryProtocol
    
    public init(repository: AuthenticationRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(request: RegisterRequest) async throws -> RegisterResponse {
        let response = try await repository.tryRegister(request: .init(email: request.email, password: request.password))
        return .init(token: response.token)
    }
    
    func validateEmail() {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
    }
}
