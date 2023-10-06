//
//  Coordinators.swift
//  FxiOS
//
//  Created by Salihcan Kahya on 3.10.2023.
//

import Foundation

enum Coordinators: CoordinatorRepresentable, GetResolver {
    case login
    case register
    
    var coordinator: Coordinator {
        switch self {
        case .login:
            return resolve(LoginCoordinator.self)
        case .register:
            return resolve(RegisterCoordinator.self)
        }
    }
    
    func resolve<T>(_ type: T.Type) -> T {
        returnResolver().resolve(T.self)!
    }
}
