//
//  AuthenticationAssembler.swift
//  FxiOS
//
//  Created by Salihcan Kahya on 3.10.2023.
//

import SwinjectAutoregistration
import Swinject
import Authentication

struct AuthenticationAssembler: Assembly {
    func assemble(container: Swinject.Container) {
        
        container.autoregister(AuthenticationRemoteAdapter.self, initializer: FirebaseAuthManager.init).inObjectScope(.weak)
        
        container.autoregister(AuthenticationRepositoryProtocol.self, initializer: AuthenticationRepository.init).inObjectScope(.weak)

        container.autoregister(LoginUseCaseProtocol.self, initializer: LoginWithEmailAndPasswordUseCase.init).inObjectScope(.weak)

        container.autoregister(RegisterUseCaseProtocol.self, initializer: RegisterUseCase.init).inObjectScope(.weak)
    }
}
