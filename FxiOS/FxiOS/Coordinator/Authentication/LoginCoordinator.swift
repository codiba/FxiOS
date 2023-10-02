//
//  LoginCoordinator.swift
//  FxiOS
//
//  Created by Salihcan Kahya on 2.10.2023.
//

import UIKit
import SwiftUI
import Authentication

final class LoginRouter: BaseRouter, LoginRouterProtocol {
    func navigateRegister() {
        push(Coordinators.register)
    }
    
    func navigateHome() {
        present(Coordinators.register)
    }
}

final class LoginCoordinator: BaseCoordinator<LoginViewModel, LoginRouterProtocol> {
    override func makeView() -> AnyView {
        return LoginView(viewModel: viewModel, router: router).anyView
    }
}
