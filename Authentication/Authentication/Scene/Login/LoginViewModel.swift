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
    
    private let loginUseCase: any LoginUseCaseProtocol
    
    public init(loginUseCase: any LoginUseCaseProtocol) {
        self.loginUseCase = loginUseCase
    }
    
    public func tryLogin() async {
        do {
            try await loginUseCase.execute(request: .init(email: email, password: password))
        } catch {
            print(error)
        }
    }
    
    func validateEmail() {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
    }
}
