//
//  LoginAssembler.swift
//  FxiOS
//
//  Created by Salihcan Kahya on 2.10.2023.
//

import SwinjectAutoregistration
import Swinject
import Authentication

struct LoginAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        container.autoregister(LoginViewModel.self, initializer: LoginViewModel.init).inObjectScope(.weak)
        
        container.autoregister(LoginRouterProtocol.self, initializer: LoginRouter.init).inObjectScope(.weak)

        container.autoregister(LoginCoordinator.self, initializer: LoginCoordinator.init).inObjectScope(.weak)
    }
}
