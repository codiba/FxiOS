//
//  FirebaseAuthManager.swift
//  FxiOS
//
//  Created by Salihcan Kahya on 3.10.2023.
//

import FirebaseAuth
import Authentication

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
    
    func register(request: RegisterRequestDTO) async throws -> RegisterResponseDTO {
        return try await withCheckedThrowingContinuation { contination in
            print(request.email)
            Auth.auth().createUser(withEmail: request.email, password: request.password) { (authResult, error) in
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
