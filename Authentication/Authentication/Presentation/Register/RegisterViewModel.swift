//
//  RegisterViewModel.swift
//  Authentication
//
//  Created by Salihcan Kahya on 3.10.2023.
//

import Foundation
import SwiftUI
import Combine

public final class RegisterViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    private let registerUseCase: RegisterUseCaseProtocol
    
    public init(registerUseCase: RegisterUseCaseProtocol) {
        self.registerUseCase = registerUseCase
    }
    
    public func tryRegister() {
        Task {
            let response = await registerUseCase.execute(request: .init(email: email, password: password))
            switch response {
            case .success(_):
                print("register successs")
            case .failure(let failure):
                print("register failure with: \(failure)")
            }
        }
    }
}
