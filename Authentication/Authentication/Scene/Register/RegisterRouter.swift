//
//  RegisterRouter.swift
//  Authentication
//
//  Created by Salihcan Kahya on 3.10.2023.
//

import Foundation

public protocol RegisterRouterProtocol {
    func dismiss()
}

struct MockRegisterRouter: RegisterRouterProtocol {
    func dismiss() {
        
    }
}
