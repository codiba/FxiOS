//
//  AuthError.swift
//  Authentication
//
//  Created by Salihcan Kahya on 2.10.2023.
//

import Foundation

public enum AuthError: Error {
    case emailAlreadyInUse
    case userDisabled
    case operationNotAllowed
    case wrongPassword
    case userNotFound
    case invalidEmail
    case weakPassword
    case tooManyRequests
    case accountExistsWithDifferentCredential
    case networkError
    case userTokenExpired
    case userMismatch
    case credentialAlreadyInUse
    case unspecifiedError
}
