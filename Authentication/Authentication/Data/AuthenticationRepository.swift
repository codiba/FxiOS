//
//  AuthenticationRepository.swift
//  Authentication
//
//  Created by Salihcan Kahya on 2.10.2023.
//


public protocol AuthenticationRepositoryProtocol {
    func tryLogin(request: LoginRequestDTO) async throws -> LoginResponseDTO
}

public protocol AuthenticationRemoteAdapter {
    func login(request: LoginRequestDTO) async throws -> LoginResponseDTO
}

public final class AuthenticationRepository: AuthenticationRepositoryProtocol {
    private let authRemote: AuthenticationRemoteAdapter
    
    public init(authRemote: AuthenticationRemoteAdapter) {
        self.authRemote = authRemote
    }
    
    public func tryLogin(request: LoginRequestDTO) async throws -> LoginResponseDTO {
        try await authRemote.login(request: request)
    }
}

