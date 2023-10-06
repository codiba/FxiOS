//
//  RegisterCoordinator.swift
//  FxiOS
//
//  Created by Salihcan Kahya on 3.10.2023.
//

import UIKit
import SwiftUI
import Authentication

final class RegisterRouter: BaseRouter, RegisterRouterProtocol {
}

final class RegisterCoordinator: BaseCoordinator<RegisterViewModel, RegisterRouterProtocol> {
    override func makeView() -> AnyView {
        return RegisterView(viewModel: viewModel, router: router).anyView
    }
}
