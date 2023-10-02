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
    
    public func tryRegister() async {
        do {
            try await registerUseCase.execute(request: .init(email: email, password: password))
        } catch {
            print(error)
        }
    }
}
