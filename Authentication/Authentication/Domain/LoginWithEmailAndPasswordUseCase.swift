//
//  LoginWithEmailAndPasswordUseCase.swift
//  Authentication
//
//  Created by Salihcan Kahya on 2.10.2023.
//

public enum LoginError: Error {
    case emailEmpty
    case emailInvalid
    case passwordEmpty
    case passwordIsWrong
    case emailNotExist
    case tryLater
    case undefined
}

public protocol LoginUseCaseProtocol {
    func execute(request: LoginRequest) async -> Result<Void, LoginError>
}

public struct LoginWithEmailAndPasswordUseCase: LoginUseCaseProtocol {
    private let repository: AuthenticationRepositoryProtocol
    
    public init(repository: AuthenticationRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(request: LoginRequest) async ->  Result<Void, LoginError> {
        do {

            guard !request.email.isEmpty else {
                return .failure(.emailEmpty)
            }
            
            guard validateEmail(request.email) else {
                return .failure(.emailInvalid)
            }
            
            let _ = try await repository.tryLogin(request: .init(email: request.email, password: request.password))
            
            return .success(())
        } catch let error as AuthError {
            guard let loginError = tryMapAuthErrorToLoginError(error) else {
                print("Login mapping not working")
                return .failure(.undefined)
            }
            
            return .failure(loginError)
        } catch {
            return .failure(.undefined)
        }
    }
    
    private func validateEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let isValided = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return isValided.evaluate(with: email)
    }
    
    func tryMapAuthErrorToLoginError(_ error: AuthError) -> LoginError? {
        switch error {
        case .wrongPassword:
            .passwordIsWrong
        case .userNotFound:
            .emailNotExist
        case .invalidEmail:
            .emailInvalid
        case .tooManyRequests:
            .tryLater
        default:
             nil
        }
    }
}
