//
//  LoginRouterProtocol.swift
//  Authentication
//
//  Created by Salihcan Kahya on 3.10.2023.
//

public protocol LoginRouterProtocol {
    func navigateRegister()
    func navigateHome()
}

struct MockLoginRouter: LoginRouterProtocol {
    func navigateRegister() {
        
    }
    
    func navigateHome() {
        
    }
}
