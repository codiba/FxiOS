//
//  AuthError+init.swift
//  FxiOS
//
//  Created by Salihcan Kahya on 3.10.2023.
//

import Authentication

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
