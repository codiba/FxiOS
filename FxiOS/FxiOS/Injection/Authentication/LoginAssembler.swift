//
//  LoginAssembler.swift
//  FxiOS
//
//  Created by Salihcan Kahya on 2.10.2023.
//

import SwinjectAutoregistration
import Swinject
import Authentication
import FirebaseAuth

struct FirebaseAuthManager: AuthenticationRemoteAdapter {
    
    func login(request: LoginRequestDTO) async throws -> LoginResponseDTO {
        return try await withCheckedThrowingContinuation { contination in
            print(request.email)
            Auth.auth().signIn(withEmail: request.email, password: request.password) { (authResult, error) in
                if let firebaseError = error as? NSError, let errorCode = firebaseError.userInfo["FIRAuthErrorUserInfoNameKey"] as? String, let authError = AuthError(firebaseErrorCode: errorCode) {
                    print(authError)
                    contination.resume(throwing: authError)
                    return
                }
                
                guard let user = authResult?.user else {
                    contination.resume(throwing: AuthError.unspecifiedError)
                    return
                }
                
                contination.resume(returning: .init(token: user.uid))
            }
        }
    }
}

struct LoginAssembler: Assembly {
    func assemble(container: Swinject.Container) {
        
        container.autoregister(AuthenticationRemoteAdapter.self, initializer: FirebaseAuthManager.init)
        
        container.autoregister(AuthenticationRepositoryProtocol.self, initializer: AuthenticationRepository.init)

        container.autoregister(LoginUseCaseProtocol.self, initializer: LoginUseCase.init)

        container.autoregister(LoginViewModel.self, initializer: LoginViewModel.init)
        
        container.autoregister(LoginRouter.self, initializer: LoginRouter.init)

        container.autoregister(LoginCoordinator.self, initializer: LoginCoordinator.init)
    }
}



extension AuthError {
    init?(firebaseErrorCode: String) {
        switch firebaseErrorCode {
        case "ERROR_EMAIL_ALREADY_IN_USE":
            self = .emailAlreadyInUse
        case "ERROR_USER_DISABLED":
            self = .userDisabled
        case "ERROR_OPERATION_NOT_ALLOWED":
            self = .operationNotAllowed
        case "ERROR_WRONG_PASSWORD":
            self = .wrongPassword
        case "ERROR_USER_NOT_FOUND":
            self = .userNotFound
        case "ERROR_INVALID_EMAIL":
            self = .invalidEmail
        case "ERROR_WEAK_PASSWORD":
            self = .weakPassword
        case "ERROR_TOO_MANY_REQUESTS":
            self = .tooManyRequests
        case "ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL":
            self = .accountExistsWithDifferentCredential
        case "ERROR_NETWORK_REQUEST_FAILED":
            self = .networkError
        case "ERROR_USER_TOKEN_EXPIRED":
            self = .userTokenExpired
        case "ERROR_USER_MISMATCH":
            self = .userMismatch
        case "ERROR_CREDENTIAL_ALREADY_IN_USE":
            self = .credentialAlreadyInUse
        default:
            return nil  // Or self = .unspecifiedError if you want to include other error codes
        }
    }
}
