//
//  RegisterAssembly.swift
//  FxiOS
//
//  Created by Salihcan Kahya on 3.10.2023.
//

import SwinjectAutoregistration
import Swinject
import Authentication

struct RegisterAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        
        container.autoregister(RegisterViewModel.self, initializer: RegisterViewModel.init).inObjectScope(.weak)
        
        container.autoregister(RegisterRouterProtocol.self, initializer: RegisterRouter.init).inObjectScope(.weak)

        container.autoregister(RegisterCoordinator.self, initializer: RegisterCoordinator.init).inObjectScope(.weak)
    }
}
