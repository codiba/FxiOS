//
//  LoginViewModel.swift
//  Authentication
//
//  Created by Salihcan Kahya on 2.10.2023.
//

import Foundation
import SwiftUI
import Combine

public final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    private let loginUseCase: LoginUseCaseProtocol
    
    public init(loginUseCase: LoginUseCaseProtocol) {
        self.loginUseCase = loginUseCase
    }
    
    public func tryLogin() async {
        do {
            try await loginUseCase.execute(request: .init(email: email, password: password))
        } catch {
            print(error)
        }
    }
}
