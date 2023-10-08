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
    
    @Published var loginError: LoginError? = nil
    @Published var loginSuccess: Bool = false
    
    private let loginUseCase: LoginUseCaseProtocol
    
    
    public init(loginUseCase: LoginUseCaseProtocol) {
        self.loginUseCase = loginUseCase
    }
    
    public func tryLogin() {
        Task {
            let response = await loginUseCase.execute(request: .init(email: email, password: password))
            
            DispatchQueue.main.async {
                switch response {
                case .success(_):
                    self.loginSuccess = true
                    print("login başarılı")
                case .failure(let error):
                    print(error)
                    self.loginError = error
                }
            }
        }
    }
}
