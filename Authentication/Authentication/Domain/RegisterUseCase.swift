//
//  RegisterUseCase.swift
//  Authentication
//
//  Created by Salihcan Kahya on 3.10.2023.
//


public enum RegisterError: Error {
    case emailEmpty
    case passwordEmpty
    case emailInvalid
    case emailAlreadyInUse
    case passwordTooWeek
    case tryLater
    case undefined
}

public protocol RegisterUseCaseProtocol {
    func execute(request: RegisterRequest) async -> Result<Void, RegisterError>
}

public struct RegisterUseCase: RegisterUseCaseProtocol {
    private let repository: AuthenticationRepositoryProtocol
    
    public init(repository: AuthenticationRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(request: RegisterRequest) async -> Result<Void, RegisterError> {
        
        do {
            guard !request.email.isEmpty else {
                return .failure(.emailEmpty)
            }
            
            guard !request.password.isEmpty else {
                return .failure(.passwordEmpty)
            }
            
            guard validateEmail(request.email) else {
                return .failure(.emailInvalid)
            }
            
            let _ = try await repository.tryRegister(request: .init(email: request.email, password: request.password))
            
            return .success(())
        } catch let error as AuthError {
            guard let registerError = tryMapAuthErrorToRegisterError(error) else {
                print("Register Error mapping not working")
                return .failure(.undefined)
            }
            
            return .failure(registerError)
        } catch {
            return .failure(.undefined)
        }
    }
    
    private func validateEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let isValided = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return isValided.evaluate(with: email)
    }
    
    func tryMapAuthErrorToRegisterError(_ error: AuthError) -> RegisterError? {
        switch error {
        case .emailAlreadyInUse:
                .emailAlreadyInUse
        case .invalidEmail:
                .emailInvalid
        case .tooManyRequests:
                .tryLater
        case .weakPassword:
                .passwordTooWeek
        default:
            nil
        }
    }
}
